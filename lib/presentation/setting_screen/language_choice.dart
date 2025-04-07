import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';
import 'package:easeops_hrms/presentation/setting_screen/screen_widgets/language_choice_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LanguageChoice extends GetView<SettingController> {
  const LanguageChoice({
    super.key,
    this.locationChecklistData,
    this.index,
  });

  final ChecklistLocationModel? locationChecklistData;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.fetchLanguageList();
        });
      },
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: customAppBar(
            title: 'Change Language',
            imageIcon: AppIcons.iconArrowBack,
            callback: () async {
              Get.back<void>();
            },
          ),
          body: SingleChildScrollView(
            child: Obx(
              () {
                if (controller.statusLocationResult.value == Status.loading) {
                  return const CustomCircularProgressIndicator();
                } else if (controller.statusLocationResult.value ==
                    Status.error) {
                  return const InternalExceptionWidget();
                }
                return Container(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (languageData.isEmpty)
                        const SizedBox()
                      else
                        Container(
                          decoration: boxDecorationWithShadow,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredLanguage.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return LanguageChoiceCard(
                                languageData:
                                    controller.filteredLanguage[index],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                  horizontal: 5.w,
                ),
                child: CustomButton(
                  btnText: 'Save',
                  callback: () async {
                    Get.find<RootController>().currentIndex.value = 0;
                    if (GetStorageHelper.getProfileData()
                        .userAccountsDetails!
                        .first
                        .privileges!
                        .contains('Superuser')) {
                      await Get.offNamedUntil<void>(
                        RoutesName.attendanceCameraScreen,
                        (route) => false,
                      );
                    } else {
                      await Get.offNamed<void>(
                        RoutesName.homeScreen,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
