import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void customSnackBar({
  required String title,
  required String message,
  Duration? duration,
  AlertType alertType = AlertType.success,
}) {
  if (Get.isSnackbarOpen) {
    return;
  }
  Get.snackbar(
    '',
    '',
    titleText: CustomText(
      title: title,
      fontSize: fontLarge,
      color: alertType == AlertType.alertMessage
          ? AppColors.kcBlackColor
          : AppColors.kcWhiteColor,
      maxLines: 2,
    ),
    messageText: CustomText(
      title: message,
      color: alertType == AlertType.alertMessage
          ? AppColors.kcBlackColor
          : AppColors.kcWhiteColor,
      maxLines: 5,
    ),
    snackPosition: SnackPosition.TOP,
    animationDuration: const Duration(milliseconds: 800),
    duration: duration ?? const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: appHMargin.copyWith(top: 1.h),
    borderRadius: 8,
    backgroundColor: alertType == AlertType.success
        ? AppColors.kcSuccessColor.withOpacity(0.9)
        : alertType == AlertType.error
            ? AppColors.kcFailedColor.withOpacity(0.9)
            : alertType == AlertType.alertError
                ? AppColors.kcAlertErrorColor.withOpacity(0.9)
                : AppColors.kcAlertMessageColor.withOpacity(0.9),
  );
}
