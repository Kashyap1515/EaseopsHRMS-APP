import 'package:easeops_hrms/presentation/base_layout/root/controller/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(RootController.new);
  }
}
