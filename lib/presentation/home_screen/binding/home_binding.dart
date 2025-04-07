import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
  }
}
