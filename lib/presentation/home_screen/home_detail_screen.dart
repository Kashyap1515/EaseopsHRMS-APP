import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/home_screen/controller/home_controller.dart';
import 'package:easeops_hrms/presentation/home_screen/model/attendance_report_user.dart';

class HomeDetailScreen extends GetView<HomeController> {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final data = Get.arguments as Map<String, dynamic>;
          controller.isCurrentMonth.value = data['is_current_month'] != null
              ? data['is_current_month'] as bool
              : true;
        });
      },
      builder: (context) {
        return Obx(
          () => BaseLayout(
            appBar: customAppBar(
              title: 'Present',
              imageIcon: AppIcons.iconArrowBack,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              callback: () {
                Get.back();
              },
            ),
            body: controller.homeDetailStatus.value == Status.loading
                ? SizedBox(
                    height: 200,
                    width: Get.size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : detailBody(
                    attendanceDataList: controller.isCurrentMonth.value
                        ? controller.thisMonthData
                        : controller.lastMonthUserData,
                  ),
          ),
        );
      },
    );
  }

  Widget detailBody({
    required List<AttendanceReportUserModel> attendanceDataList,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: all16,
        child: Column(
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
                  title: controller.isCurrentMonth.value
                      ? 'This Month Attendances'
                      : 'Last Month Attendances',
                  fontSize: fontTempLarge,
                ),
              ],
            ),
            sbh10,
            if (attendanceDataList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (attendanceDataList.first.attendanceList ?? [])
                    .reversed
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  var attendanceData =
                      (attendanceDataList.first.attendanceList ?? [])
                          .reversed
                          .toList()[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.kcWhiteColor,
                      borderRadius: br8,
                    ),
                    padding: all10,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                title: controller.formatDateTime(
                                  convertDateTimeLocalTimeZone(
                                    attendanceData.markedAt!,
                                  ),
                                ),
                                fontSize: fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            CustomText(
                              title: attendanceData.totalTimeSpentInMinutes ==
                                      null
                                  ? '-'
                                  : attendanceData.markedAt!.day ==
                                          DateTime.now().day
                                      ? '-'
                                      : (AttendanceReportUserModel().formatTime(
                                              attendanceData
                                                      .totalTimeSpentInMinutes ??
                                                  0))
                                          .toString(),
                              color: AppColors.kcGreyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        for (var session
                            in attendanceData.sessionList ?? <SessionList>[])
                          Row(
                            children: [
                              CustomText(
                                title: controller.formatDate(
                                  convertDateTimeLocalTimeZone(
                                    session.checkinAt!,
                                  ),
                                ),
                                fontSize: fontBase,
                              ),
                              sbw5,
                              CustomText(
                                title: '-',
                                fontSize: fontBase,
                              ),
                              sbw5,
                              CustomText(
                                title: session.checkoutAt == null
                                    ? attendanceData.markedAt!.day ==
                                            DateTime.now().day
                                        ? 'N/A'
                                        : 'Missed'
                                    : controller.formatDate(
                                        convertDateTimeLocalTimeZone(
                                          session.checkoutAt!,
                                        ),
                                      ),
                                color: session.checkoutAt == null
                                    ? attendanceData.markedAt!.day ==
                                            DateTime.now().day
                                        ? null
                                        : AppColors.dangerColor
                                    : null,
                                fontSize: fontBase,
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            sbh20,
          ],
        ),
      ),
    );
  }
}
