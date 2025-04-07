import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/screen_widgets/profile_custom_card.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar(
        title: 'Settings',
        imageIcon: AppIcons.iconArrowBack,
        callback: Get.back<void>,
      ),
      body: settingBody(controller: controller),
    );
  }
}

class SettingTabScreen extends GetView<SettingController> {
  const SettingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: customAppBar(
        title: 'Settings',
        imageIcon: AppIcons.iconMenu,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        callback: () {
          controller.scaffoldKey.currentState?.openDrawer();
        },
      ),
      scaffoldKey: controller.scaffoldKey,
      drawer: customDrawer(),
      body: settingBody(controller: controller),
    );
  }
}

Widget settingBody({required SettingController controller}) {
  return GetBuilder(
    init: controller,
    initState: (state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller
          ..loadCachedLocation()
          ..loadCachedLanguage();
      });
    },
    builder: (context) {
      return Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: all16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh10,
                CustomText(
                  title: 'Change Location',
                  fontSize: fontLarge,
                  fontWeight: FontWeight.w500,
                ),
                sbh10,
                Container(
                  decoration: boxDecorationWithShadow,
                  child: Column(
                    children: [
                      ProfileCustomCard(
                        onItemTapped: () async {
                          if (await NetworkInfo().isConnected()) {
                            await Get.toNamed<void>(
                              RoutesName.locationChoice,
                            );
                          } else {
                            customSnackBar(
                              title: AppStrings.strOffline,
                              message: AppStrings.strNoInternetFound,
                              alertType: AlertType.error,
                            );
                          }
                        },
                        itemIcon: AppIcons.iconSwitchLocation,
                        isTranslated: true,
                        itemTitle: GetStorageHelper.getCurrentLocationData() ==
                                null
                            ? 'Select Location'.obs.value
                            : controller.selectedLocation.value.locationName,
                      ),
                    ],
                  ),
                ),
                sbh20,
                CustomText(
                  title: 'Set Your Preferences',
                  fontSize: fontLarge,
                  fontWeight: FontWeight.w500,
                ),
                sbh10,
                Container(
                  decoration: boxDecorationWithShadow,
                  child: Column(
                    children: [
                      ProfileCustomCard(
                        onItemTapped: () async {
                          await Get.toNamed<void>(
                            RoutesName.languageChoice,
                          );
                        },
                        itemIcon: AppIcons.iconSwitchLocation,
                        itemTitle: 'Change Language',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
