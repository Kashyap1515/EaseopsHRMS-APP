import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LocationChoiceCard extends GetView<SettingController> {
  const LocationChoiceCard({
    required this.checklistData,
    this.isTopLocation = false,
    super.key,
  });

  final ChecklistLocationModel checklistData;
  final bool isTopLocation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (controller.selectedLocation.value != checklistData) {
          await controller.setSelectedLocation(checklistData);
        }
      },
      child: Container(
        padding: all16,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.kcBorderColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: checklistData.locationName,
                    child: CustomText(
                      title: checklistData.locationName,
                      fontSize: fontLarge,
                      color: AppColors.kcBlackColor,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (!isTopLocation) SizedBox(width: 5.w),
            if (!isTopLocation)
              Obx(
                () => Container(
                  width: 2.5.h,
                  height: 2.5.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.selectedLocation.value.locationId ==
                              checklistData.locationId
                          ? AppColors.primaryColor
                          : AppColors.lightColor,
                      width: 0.5.w,
                    ),
                  ),
                  padding: EdgeInsets.all(1.w),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedLocation.value.locationId ==
                              checklistData.locationId
                          ? AppColors.primaryColor
                          : AppColors.kcTransparentColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
