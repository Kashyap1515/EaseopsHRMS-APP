// ignore_for_file: avoid_dynamic_calls

import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/widgets/custom_dropdown_new.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PunchInOutScreen extends GetView<AttendanceController> {
  const PunchInOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (controller.userLat.value == 0.0 ||
              controller.userLon.value == 0.0 ||
              controller.locationAddress.value == '') {
            await controller.setLocation();
          }
        });
      },
      builder: (context) {
        return Obx(
          () => Scaffold(
            appBar: customAppBar(
              title: controller.isOnboardUser.value
                  ? AppStrings.strUpdateUserSelfie
                  : AppStrings.strMarkAttendance,
              callback: () {
                controller.clearAllData();
                Get.back<void>();
              },
              imageIcon: AppIcons.iconArrowBack,
              actions: [
                CustomPopupMenu(
                  icon: const Icon(
                    Icons.info,
                    color: AppColors.kcWhiteColor,
                  ),
                  onSelected: (value) {
                    if (value == AppStrings.strUpdateProfile) {
                      controller.isOnboardUser.value = true;
                      controller.selectedUserId.value = '';
                      controller.selectedUserName.value = '';
                    } else if (value == AppStrings.strClickMarkAttendance) {
                      controller.isOnboardUser.value = false;
                      controller.selectedUserId.value = '';
                      controller.selectedUserName.value = '';
                    } else {
                      controller.isOnboardUser.value = false;
                      controller.selectedUserId.value = '';
                      controller.selectedUserName.value = '';
                    }
                  },
                  menuList: [
                    if (controller.isOnboardUser.value)
                      AppStrings.strClickMarkAttendance
                    else
                      AppStrings.strUpdateProfile,
                  ],
                ),
              ],
            ),
            backgroundColor: AppColors.backgroundColor,
            body: SingleChildScrollView(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sbh20,
                      if (controller.isOnboardUser.value) userInfoCard(),
                      if (controller.isOnboardUser.value) customUserInfoCard(),
                      if (controller.isOnboardUser.value) sbh20,
                      if (controller.imageFile != null)
                        Container(
                          height: controller.isOnboardUser.value
                              ? Get.size.height / 1.6
                              : Get.size.height / 1.6,
                          width: controller.isOnboardUser.value
                              ? Get.size.width
                              : Get.size.width,
                          margin: symetricH5,
                          decoration: BoxDecoration(
                            borderRadius: br8,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.kcBorderColor,
                                blurRadius: 2,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: br8,
                            child: Image.file(
                              controller.imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      sbh14,
                      if (!controller.isOnboardUser.value) customLocationCard(),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      btnText: controller.isOnboardUser.value
                          ? AppStrings.strUpdateUserSelfie
                          : controller.locationAddress.value == ''
                              ? 'Please wait, fetching location...'
                              : AppStrings.strMarkAttendance,
                      isLoading: controller.attendancePunchedStatus.value ==
                          Status.loading,
                      bgColor: controller.locationAddress.value == ''
                          ? AppColors.kcGreyColor
                          : AppColors.primaryColor,
                      callback: () async {
                        if (controller.attendancePunchedStatus.value ==
                            Status.loading) {
                          return;
                        }
                        if (controller.isOnboardUser.value) {
                          if (controller.selectedUserId.value == '') {
                            customSnackBar(
                              title: AppStrings.textError,
                              message: 'User is not selected.',
                              alertType: AlertType.alertError,
                            );
                            return;
                          }
                        } else {
                          if (controller.locationAddress.value == '') {
                            customSnackBar(
                              title: 'Oops..!',
                              message:
                                  'Not able to fetch location, Please try again later..',
                              alertType: AlertType.alertError,
                            );
                            await controller.setLocation();
                            return;
                          }
                        }
                        await controller.onAttendanceButtonPressed();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customUserInfoCard() {
    return CustomDropDownNew(
      isMapList: true,
      hintText: 'Select User',
      selectedItem: controller.selectedUserName.value != ''
          ? controller.selectedUserName.value
          : null,
      itemList: controller.userListData.toList(),
      padding: const EdgeInsets.only(right: 8),
      onTapCallback: (dynamic val) {
        controller.selectedUserId.value = (val['id'] ?? '').toString();
        controller.selectedUserName.value = (val['label'] ?? '').toString();
      },
    );
  }

  Widget userInfoCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: br4,
        color: AppColors.secondaryColor.withOpacity(0.3),
      ),
      width: double.infinity,
      padding: all10,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Info : Please Use this only when you want to set Profile Photo.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          sbw20,
          InkWell(
            onTap: () {
              controller.isOnboardUser.value = false;
              controller.selectedUserId.value = '';
              controller.selectedUserName.value = '';
            },
            child: const Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget customLocationCard() {
    return Container(
      margin: all3,
      padding: all12,
      width: double.infinity,
      decoration: boxDecorationWithShadow,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined),
              sbw10,
              Expanded(
                child: CustomText(
                  title: controller.locationAddress.value,
                  fontSize: fontBase,
                ),
              ),
            ],
          ),
          sbh10,
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.date_range_outlined,
                size: 22,
              ),
              sbw10,
              Expanded(
                child: CustomText(
                  title: DateFormat('d MMMM, yyyy - HH:mm a')
                      .format(DateTime.now()),
                  fontSize: fontBase,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
