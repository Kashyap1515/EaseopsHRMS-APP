import 'package:easeops_hrms/app_export.dart';

class AuthGuard extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (GetStorageHelper.getUserData().token == null) {
      return const RouteSettings(name: RoutesName.loginScreen);
    } else {}
    return null;
  }
}
