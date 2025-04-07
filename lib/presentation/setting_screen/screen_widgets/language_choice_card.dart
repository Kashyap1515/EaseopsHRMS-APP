import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/language_choice_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LanguageChoiceCard extends GetView<SettingController> {
  const LanguageChoiceCard({
    required this.languageData,
    super.key,
  });

  final LanguageModel languageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (controller.selectedLanguage.value != languageData) {
          await controller.setSelectedLanguage(languageData);
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
                    message: languageData.languageName,
                    child: CustomText(
                      title: languageData.languageName ?? '',
                      fontSize: fontLarge,
                      color: AppColors.kcBlackColor,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                      isOriginal: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w),
            Obx(
              () => Container(
                width: 2.5.h,
                height: 2.5.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.selectedLanguage.value.languageCode ==
                            languageData.languageCode
                        ? AppColors.primaryColor
                        : AppColors.lightColor,
                    width: 0.5.w,
                  ),
                ),
                padding: EdgeInsets.all(1.w),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.selectedLanguage.value.languageCode ==
                            languageData.languageCode
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
