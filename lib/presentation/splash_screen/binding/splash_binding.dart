import 'package:easeops_hrms/app_export.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashController.new);
  }
}
