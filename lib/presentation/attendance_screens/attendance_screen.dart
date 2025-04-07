import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
          title: 'Attendance',
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                sbh10,
                attendanceOverview(),
                SizedBox(height: 2.h),
                CustomText(
                  title: 'Attendance Summary',
                  fontSize: fontHeader6,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),
                attendanceSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attendanceSummary() {
    return Container(
      margin: all3,
      padding: all12,
      decoration: boxDecorationWithShadow,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index != 0) sbh10,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: '21 July',
                          fontSize: fontBase,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          title: 'wednesday',
                          fontSize: fontSmall,
                        ),
                      ],
                    ),
                  ),
                  sbw10,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          title: 'Present',
                          fontSize: fontBase,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          title: '9:00 Hrs',
                          fontSize: fontSmall,
                        ),
                      ],
                    ),
                  ),
                  sbw10,
                  SvgPicture.asset(
                    AppIcons.iconRightArrow,
                    width: 2.w,
                    height: 2.h,
                  ),
                ],
              ),
              if (index != 3) sbh10,
              if (index != 3) const CustomDivider(),
            ],
          );
        },
      ),
    );
  }

  Widget attendanceOverview() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customCard(
              title: 'Present',
              subTitle: '0',
            ),
            customCard(
              title: 'Absent',
              subTitle: '0',
            ),
            customCard(
              title: 'Half Day',
              subTitle: '0',
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customCard(
              title: 'Week Off',
              subTitle: '0',
            ),
            customCard(
              title: 'Fine',
              subTitle: '0:00',
            ),
            customCard(
              title: 'Overtime',
              subTitle: '0:00',
            ),
          ],
        ),
      ],
    );
  }

  Widget customCard({
    required String title,
    required String subTitle,
  }) {
    return Expanded(
      child: Container(
        margin: all3,
        padding: all12,
        decoration: boxDecorationWithShadow,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: title,
              fontSize: fontSmall,
            ),
            CustomText(
              title: subTitle,
              fontSize: fontLarge,
            ),
          ],
        ),
      ),
    );
  }
}
