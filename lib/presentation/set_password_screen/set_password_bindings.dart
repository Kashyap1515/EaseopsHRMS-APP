import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/set_password_screen/set_password_controller.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SetPasswordController.new);
  }
}
