import 'package:easeops_hrms/app_export.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return RouterOutlet.builder(
      delegate: Get.rootDelegate,
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute:
                kIsWeb ? RoutesName.loginScreen : RoutesName.splashScreen,
            delegate: Get.rootDelegate,
            anchorRoute: '/',
            filterPages: (afterAnchor) {
              return afterAnchor.take(2);
            },
          ),
        );
      },
    );
  }
}
