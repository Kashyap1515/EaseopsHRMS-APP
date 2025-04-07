import 'package:easeops_hrms/app_export.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Image.asset(
          AppImages.backGroundImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
