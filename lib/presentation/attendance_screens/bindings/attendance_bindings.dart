import 'package:easeops_hrms/app_export.dart';

class AttendanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AttendanceController.new);
  }
}
