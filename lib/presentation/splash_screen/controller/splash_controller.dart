import 'package:easeops_hrms/app_export.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    DeviceSize.height = Get.size.height;
    DeviceSize.width = Get.size.width;
    Future.delayed(const Duration(milliseconds: 200), () async {
      if (GetStorageHelper.getUserData().token != null) {
        if (GetStorageHelper.getProfileData()
            .email!
            .contains('admin') ||
            GetStorageHelper.getProfileData()
                .email!
                .contains('store')) {
          await Get.offNamedUntil<void>(
            RoutesName.attendanceCameraScreen,
            (route) => false,
          );
        } else {
          await Get.offNamedUntil<void>(
            RoutesName.homeScreen,
            (route) => false,
          );
        }
      } else {
        await Get.offNamed<void>(RoutesName.loginScreen);
      }
    });
  }
}
