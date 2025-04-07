// ignore_for_file: deprecated_member_use
import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BaseLayout<T extends dynamic> extends StatelessWidget {
  const BaseLayout({
    required this.body,
    this.appBar,
    this.drawer,
    super.key,
    this.scaffoldKey,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: body,
      backgroundColor: AppColors.backgroundColor,
      drawer: drawer,
      // bottomNavigationBar: Obx(
      //   () =>
      //       BottomNavigationBar(
      //     currentIndex: Get.find<RootController>().currentIndex.value,
      //     onTap: (index) async {
      //       Get.find<RootController>().currentIndex.value = index;
      //       switch (index) {
      //         case 0:
      //           if (GetStorageHelper.getProfileData()
      //               .userAccountsDetails!
      //               .first
      //               .privileges!
      //               .contains('Superuser')) {
      //             await Get.offNamedUntil<void>(
      //               RoutesName.attendanceCameraScreen,
      //               (route) => false,
      //             );
      //           } else {
      //             await Get.offNamedUntil<void>(
      //               RoutesName.homeScreen,
      //               (route) => false,
      //             );
      //           }
      //         case 1:
      //           await Get.offNamedUntil<void>(
      //             RoutesName.settingTabScreen,
      //             (route) => false,
      //           );
      //         default:
      //           if (GetStorageHelper.getProfileData()
      //               .userAccountsDetails!
      //               .first
      //               .privileges!
      //               .contains('Superuser')) {
      //             await Get.offNamedUntil<void>(
      //               RoutesName.attendanceCameraScreen,
      //               (route) => false,
      //             );
      //           } else {
      //             await Get.offNamedUntil<void>(
      //               RoutesName.homeScreen,
      //               (route) => false,
      //             );
      //           }
      //       }
      //     },
      //     items: Get.find<RootController>().isRoleChange.value
      //         ? buildBottomNavBarItems()
      //         : buildBottomNavBarItems(),
      //     elevation: 0,
      //     type: BottomNavigationBarType.fixed,
      //     selectedLabelStyle: TextStyle(
      //       fontSize: fontSmallMedium,
      //       fontWeight: FontWeight.w500,
      //     ),
      //     selectedFontSize: fontSmallMedium,
      //     unselectedFontSize: fontSmallMedium,
      //     unselectedLabelStyle: TextStyle(
      //       fontSize: fontSmallMedium,
      //       fontWeight: FontWeight.w500,
      //     ),
      //     backgroundColor: AppColors.kcWhiteColor,
      //     selectedItemColor: AppColors.primaryColor,
      //     unselectedItemColor: AppColors.lightColor,
      //     showUnselectedLabels: true,
      //     showSelectedLabels: true,
      //   ),
      // ),
    );
  }

  // Method to build BottomNavigationBar items based on user role
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      if (GetStorageHelper.getProfileData()
          .userAccountsDetails!
          .first
          .privileges!
          .contains('Superuser'))
        buildNavItem(AppIcons.iconAttendanceIcon, 'Attendance', 0)
      else
        buildNavItem(AppIcons.iconHome, 'Home', 0),
      buildNavItem(AppIcons.iconProfile, 'Profile', 1),
    ];
  }

  // Method to build individual BottomNavigationBarItem
  BottomNavigationBarItem buildNavItem(
    String iconPath,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 0.5.h),
        child: SvgPicture.asset(
          iconPath,
          height: index == 1 ? 3.8.h : 4.h,
          color: Get.find<RootController>().currentIndex.value == index
              ? AppColors.primaryColor
              : AppColors.lightColor,
        ),
      ),
      label: label,
    );
  }
}
