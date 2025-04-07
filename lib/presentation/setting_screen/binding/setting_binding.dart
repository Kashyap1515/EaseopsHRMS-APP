import 'package:easeops_hrms/app_export.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(SettingController.new)
      ..lazyPut(RootController.new);
  }
}
