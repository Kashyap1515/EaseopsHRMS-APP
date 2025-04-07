import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';
import 'package:easeops_hrms/presentation/setting_screen/screen_widgets/location_choice_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChecklistLocation extends GetView<SettingController> {
  const ChecklistLocation({
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
          if (Get.arguments != null) {
            final data = Get.arguments as Map<String, dynamic>;
            controller.isFromLogin.value =
                (data['isFromLogin'] ?? false) as bool;
          }
          controller.fetchMyLocationRequest();
        });
      },
      builder: (context) {
        return Obx(
          () => Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: customAppBar(
              title: controller.isFromLogin.value
                  ? 'Select Location'
                  : 'Change Location',
              imageIcon:
                  controller.isFromLogin.value ? null : AppIcons.iconArrowBack,
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
                        if (controller.locationsResultModel.data == null ||
                            controller.locationsResultModel.data!.isEmpty)
                          const SizedBox()
                        else
                          Container(
                            decoration: boxDecorationWithShadow,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (controller.filteredLocations.isEmpty
                                      ? controller.locationsResultModel.data ??
                                          []
                                      : controller.filteredLocations)
                                  .length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return LocationChoiceCard(
                                  checklistData: (controller
                                          .filteredLocations.isEmpty
                                      ? controller.locationsResultModel.data ??
                                          []
                                      : controller.filteredLocations)[index],
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
                              .email!
                              .contains('admin') ||
                          GetStorageHelper.getProfileData()
                              .email!
                              .contains('store')) {
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
          ),
        );
      },
    );
  }
}
