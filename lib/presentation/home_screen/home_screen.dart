import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/home_screen/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await controller.getLocalTimezone();
          await controller.getTodayData();
          await controller.getThisMonthData();
          await controller.getLastMonthData();
        });
      },
      builder: (context) {
        return Obx(
          () => BaseLayout(
            appBar: customAppBar(
              title: 'Easeops HRMS',
              imageIcon: AppIcons.iconMenu,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              // imageIcon1: AppIcons.iconNotification,
              callback: () {
                controller.scaffoldKey.currentState?.openDrawer();
              },
            ),
            scaffoldKey: controller.scaffoldKey,
            drawer: customDrawer(),
            body: controller.homeStatus.value == Status.loading
                ? SizedBox(
                    height: 200,
                    width: Get.size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: all16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title:
                                'Good Morning, ${GetStorageHelper.getUserData().name ?? ''}',
                            color: AppColors.kcBlackColor,
                            fontSize: fontHeader6,
                            fontWeight: FontWeight.w500,
                          ),
                          sbh20,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.kcWhiteColor,
                                    borderRadius: br8,
                                  ),
                                  padding: all10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: CustomText(
                                              title: 'Punch In',
                                              color: AppColors.kcGreyColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.kcSuccessColor,
                                            ),
                                            padding: all3,
                                            child: const Icon(
                                              Icons.done,
                                              size: 18,
                                              color: AppColors.kcWhiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 60,
                                        child: Divider(height: 20),
                                      ),
                                      Column(
                                        children: controller.checkinTimes
                                            .map((value) {
                                          return CustomText(
                                            title: value,
                                            color: AppColors.kcBlackColor,
                                            fontSize: fontTempLarge,
                                            fontWeight: FontWeight.w500,
                                          );
                                        }).toList(),
                                      ),
                                      sbh10,
                                      CustomButton(
                                        btnText: 'Checked In',
                                        callback: () {},
                                        btnHeight: 35,
                                        bgColor: !controller.checkoutTimes
                                                .contains('-')
                                            ? AppColors.primaryColor
                                            : AppColors.kcGreyColor,
                                        isOutLinedButton: controller
                                            .checkoutTimes
                                            .contains('-'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sbw10,
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.kcWhiteColor,
                                    borderRadius: br8,
                                  ),
                                  padding: all10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              title: 'Punch Out',
                                              color: AppColors.kcGreyColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 60,
                                        child: Divider(height: 20),
                                      ),
                                      Column(
                                        children: controller.checkoutTimes
                                            .map((value) {
                                          return CustomText(
                                            title: value,
                                            color: AppColors.kcBlackColor,
                                            fontSize: fontTempLarge,
                                            fontWeight: FontWeight.w500,
                                          );
                                        }).toList(),
                                      ),
                                      sbh5,
                                      sbh10,
                                      CustomButton(
                                        btnText: 'Punch Out',
                                        callback: () {},
                                        btnHeight: 35,
                                        bgColor: !controller.checkinTimes
                                                .contains('-')
                                            ? AppColors.primaryColor
                                            : AppColors.kcGreyColor,
                                        isOutLinedButton: !controller
                                            .checkinTimes
                                            .contains('-'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sbh20,
                          showMonthWiseData(isCurrentMonth: true),
                          sbh20,
                          showMonthWiseData(isCurrentMonth: false),
                          sbh20,
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 20,
                                color: AppColors.primaryColor,
                              ),
                              sbw10,
                              CustomText(
                                title: 'Need to Apply',
                                fontSize: fontTempLarge,
                              ),
                            ],
                          ),
                          sbh10,
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.kcWhiteColor,
                              borderRadius: br8,
                            ),
                            padding: all10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: '10:00 AM - 06:00 PM',
                                          fontSize: fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const CustomText(
                                          title: '15th Dec Missing Punch In',
                                          color: AppColors.kcGreyColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          sbh20,
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 4,
                          //       height: 20,
                          //       color: AppColors.primaryColor,
                          //     ),
                          //     sbw10,
                          //     CustomText(
                          //       title: 'Upcoming Birthday',
                          //       fontSize: fontTempLarge,
                          //     ),
                          //   ],
                          // ),
                          // sbh10,
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget showMonthWiseData({bool isCurrentMonth = true}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              color: AppColors.primaryColor,
            ),
            sbw10,
            CustomText(
              title:
                  '${isCurrentMonth ? controller.currentMonthName.value : controller.lastMonthName.value} Attendance',
              fontSize: fontTempLarge,
            ),
          ],
        ),
        sbh10,
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kcWhiteColor,
                  borderRadius: br8,
                ),
                padding: all10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenColor,
                          ),
                          padding: all5,
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            child: CustomText(
                              title: controller
                                  .convertTimeToWorkingDays(isCurrentMonth
                                      ? controller.thisMonthPresentCount.value
                                      : controller.lastMonthPresentCount.value)
                                  .toString(),
                              color: AppColors.kcWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        sbw10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: isCurrentMonth
                                    ? controller.thisMonthPresentCount.value
                                    : controller.lastMonthPresentCount.value,
                                fontSize: fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                              const CustomText(
                                title: 'Present',
                                color: AppColors.kcGreyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sbw10,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kcWhiteColor,
                  borderRadius: br8,
                ),
                padding: all10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kcFailedColor,
                          ),
                          padding: all5,
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            child: CustomText(
                              title: controller
                                  .convertTimeToWorkingDays(isCurrentMonth
                                      ? controller.thisMonthAbsentCount.value
                                      : controller.lastMonthAbsentCount.value)
                                  .toString(),
                              color: AppColors.kcWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        sbw10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: isCurrentMonth
                                    ? controller.thisMonthAbsentCount.value
                                    : controller.lastMonthAbsentCount.value,
                                fontSize: fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                              const CustomText(
                                title: 'Absent',
                                color: AppColors.kcGreyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        sbh10,
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kcWhiteColor,
                  borderRadius: br8,
                ),
                padding: all10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor,
                          ),
                          padding: all5,
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            child: CustomText(
                              title: controller
                                  .convertTimeToWorkingDays(isCurrentMonth
                                      ? controller.thisMonthLateCount.value
                                      : controller.lastMonthLateCount.value)
                                  .toString(),
                              color: AppColors.kcWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        sbw10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: isCurrentMonth
                                    ? controller.thisMonthLateCount.value
                                    : controller.lastMonthLateCount.value,
                                fontSize: fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                              const CustomText(
                                title: 'Late',
                                color: AppColors.kcGreyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sbw10,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kcWhiteColor,
                  borderRadius: br8,
                ),
                padding: all10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          padding: all5,
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            child: CustomText(
                              title: (isCurrentMonth
                                      ? controller.thisMonthHolidaysCount.value
                                      : controller.lastMonthHolidaysCount.value)
                                  .toString(),
                              color: AppColors.kcWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        sbw10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title:
                                    '${isCurrentMonth ? controller.thisMonthHolidaysCount.value : controller.lastMonthHolidaysCount.value}',
                                fontSize: fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                              const CustomText(
                                title: 'Holidays',
                                color: AppColors.kcGreyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
