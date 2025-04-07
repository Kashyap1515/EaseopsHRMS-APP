import 'package:easeops_hrms/app_export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Logger().init(kReleaseMode ? LogMode.live : LogMode.debug);
    if (kReleaseMode) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
    }
    Get.put(NetworkInfo());
  }
}
