import 'package:camera/camera.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/firebase_options.dart';
import 'package:easeops_hrms/main.dart';
import 'package:easeops_hrms/utils/flavor_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'EaseOps',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (!kIsWeb) {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
  }
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  setPathUrlStrategy();
  FlavorConfig(
    flavor: Flavor.staging,
    values: FlavorValues(
      appName: 'EaseOps Stag',
      baseUrl: 'https://stage-api.moonwyre.com/',
    ),
  );
  Get.put(RootController());
  await GetStorage.init();
  runApp(const MyApp());
}
