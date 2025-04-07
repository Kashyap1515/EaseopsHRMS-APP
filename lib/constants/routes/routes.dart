import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/attendance_screens/camera_screen.dart';
import 'package:easeops_hrms/presentation/attendance_screens/punch_detail_screen.dart';
import 'package:easeops_hrms/presentation/home_screen/binding/home_binding.dart';
import 'package:easeops_hrms/presentation/home_screen/home_detail_screen.dart';
import 'package:easeops_hrms/presentation/home_screen/home_screen.dart';
import 'package:easeops_hrms/presentation/setting_screen/language_choice.dart';
import 'package:easeops_hrms/presentation/setting_screen/location_choice.dart';

class AppPages {
  AppPages._();

  static const initial = '/';

  static final routes = [
    // ignore: inference_failure_on_instance_creation
    GetPage(
      name: '/',
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      children: [
        GetPage(
          name: RoutesName.splashScreen,
          page: () => const SplashScreen(),
          bindings: [
            SplashBinding(),
          ],
        ),
        GetPage(
          name: RoutesName.loginScreen,
          page: () => const LoginScreen(),
          bindings: [
            LoginBinding(),
          ],
        ),
        GetPage(
          name: RoutesName.homeScreen,
          page: () => const HomeScreen(),
          bindings: [
            HomeBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.homeDetailScreen,
          page: () => const HomeDetailScreen(),
          bindings: [
            HomeBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.setNewPasswordScreen,
          page: () => const SetPasswordScreen(),
          bindings: [
            SetPasswordBinding(),
          ],
        ),
        GetPage(
          name: RoutesName.punchDetailScreen,
          page: () => const PunchInOutScreen(),
          bindings: [
            AttendanceBindings(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.attendanceCameraScreen,
          page: () => const AttendanceCameraScreen(),
          bindings: [
            AttendanceBindings(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.settingScreen,
          page: () => const SettingScreen(),
          bindings: [
            SettingBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.settingTabScreen,
          page: () => const SettingTabScreen(),
          bindings: [
            SettingBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.locationChoice,
          page: ChecklistLocation.new,
          bindings: [
            SettingBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RoutesName.languageChoice,
          page: LanguageChoice.new,
          bindings: [
            SettingBinding(),
          ],
          middlewares: [AuthGuard()],
          transition: Transition.noTransition,
        ),
      ],
    ),
  ];
}
