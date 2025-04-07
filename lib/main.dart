import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/firebase_options.dart';
import 'package:easeops_hrms/utils/flavor_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  if (!kIsWeb) {
    if (Firebase.apps.isEmpty) {
      if (Platform.isIOS) {
        await Firebase.initializeApp(name: 'EaseOps');
      } else {
        await Firebase.initializeApp(
          name: 'EaseOps',
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      };
    }
  } else {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: 'EaseOps',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  setPathUrlStrategy();
  FlavorConfig(
    flavor: Flavor.production,
    values: FlavorValues(
      appName: 'EaseOps HRMS',
      baseUrl: 'https://api.moonwyre.com/',
    ),
  );
  Get.put(RootController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> notifications = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme,
            ).apply(bodyColor: Colors.black, displayColor: Colors.black),
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          initialBinding: InitialBindings(),
          initialRoute: kIsWeb
              ? GetStorageHelper.getUserData().token != null
                  ? RoutesName.homeScreen
                  : RoutesName.loginScreen
              : RoutesName.splashScreen,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
