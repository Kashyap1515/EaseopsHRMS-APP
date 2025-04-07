import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/base_layout/view/profile_card.dart';

Drawer customDrawer() {
  return Drawer(
    width: Get.size.width * 0.72,
    child: SizedBox(
      height: Get.size.height,
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height * 0.60,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (GetStorageHelper.getProfileData()
                            .email!
                            .contains('admin') ||
                        GetStorageHelper.getProfileData()
                            .email!
                            .contains('store'))
                      customTile(
                        title: 'Attendance',
                        icon: AppIcons.iconAttendanceIcon,
                        onTapCallBack: () async {
                          Get.back<void>();
                          Get.offNamed(RoutesName.attendanceCameraScreen);
                        },
                      )
                    else
                      customTile(
                        title: 'Home',
                        icon: AppIcons.iconHome,
                        onTapCallBack: () async {
                          Get.back<void>();
                          Get.offNamed(RoutesName.homeScreen);
                        },
                      ),
                    customTile(
                      title: 'Settings',
                      icon: AppIcons.iconSetting,
                      onTapCallBack: () async {
                        Get.back<void>();
                        Get.offNamed(RoutesName.settingTabScreen);
                      },
                    ),
                    customTile(
                      title: 'Logout',
                      icon: AppIcons.iconLogout,
                      onTapCallBack: () async {
                        Get.find<RootController>().currentIndex.value = 0;
                        await GetStorageHelper.clearAll();
                        Get.back<void>();
                        await Get.offAllNamed<void>(RoutesName.loginScreen);
                      },
                    ),
                    const Spacer(),
                    Align(
                      child: CustomText(
                        title:
                            'Version : ${GetStorageHelper.getValue(GetStorageKeys.keyVersion) ?? appVersion}',
                        fontSize: fontBase,
                        color: AppColors.lightColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sbh5,
                    CustomText(
                      title:
                          '${AppStrings.appName} ${DateTime.now().year}. All Rights Reserved',
                      fontSize: 11,
                      color: AppColors.kcBlackColor,
                    ),
                    sbh10,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customTile({
  required String title,
  required String icon,
  required VoidCallback onTapCallBack,
}) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: symetricH16.copyWith(bottom: 20),
    child: Theme(
      data: Styles.removeDefaultSplash,
      child: InkWell(
        onTap: onTapCallBack,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 18,
              width: 18,
              color: AppColors.kcBlackColor,
            ),
            sbw16,
            Expanded(
              child: CustomText(
                title: title,
                color: AppColors.kcBlackColor,
                fontSize: fontTempLarge,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
