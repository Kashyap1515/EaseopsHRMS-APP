import 'package:easeops_hrms/app_export.dart';

class SetPasswordController extends GetxController {
  RxBool isVisibleForPassword = true.obs;
  RxBool isVisibleForNewPassword = true.obs;
  RxString tokenAuth = ''.obs;
  final NetworkApiService _apiService = NetworkApiService();
  RxBool allOKToNavigateLogin = false.obs;
  RxBool isSetPasswordLoading = false.obs;

  final GlobalKey<FormState> setPasswordForm = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Rx<Status> setNewPassStatus = Status.completed.obs;
  RxBool obscureTextPassword = true.obs;
  RxBool obscureTextConfirmPassword = true.obs;
  RxString passwordToggleImagePassword = AppIcons.iconNotVisible.obs;
  RxString passwordToggleImageConfirmPassword = AppIcons.iconNotVisible.obs;

  void visibilityToggle({bool isPassword = false}) {
    if (isPassword) {
      obscureTextPassword.value = !obscureTextPassword.value;
      if (obscureTextPassword.value) {
        passwordToggleImagePassword.value = AppIcons.iconNotVisible;
      } else {
        passwordToggleImagePassword.value = AppIcons.iconVisibility;
      }
    } else {
      obscureTextConfirmPassword.value = !obscureTextConfirmPassword.value;
      if (obscureTextConfirmPassword.value) {
        passwordToggleImageConfirmPassword.value = AppIcons.iconNotVisible;
      } else {
        passwordToggleImageConfirmPassword.value = AppIcons.iconVisibility;
      }
    }
  }

  Future<void> btnSetNewPwdPressed() async {}

  Future<void> saveForm(BuildContext context) async {
    final isValid = setPasswordForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    setPasswordForm.currentState!.save();
    if (tokenAuth.value == '') {
      customSnackBar(
        title: 'Error',
        message: 'Not Authenticated User',
        alertType: AlertType.alertError,
      );
      return;
    }
    final setPasswordMapBody = <String, dynamic>{
      'password': confirmPasswordController.text,
      'token': tokenAuth.value,
    };
    isSetPasswordLoading.value = true;
    try {
      final result = await _apiService.postResponse(
        ApiEndPoints.apiIssues,
        setPasswordMapBody,
      );
      if (result != null) {
        customSnackBar(
          title: 'Success',
          message: 'Password set successfully',
        );
      }
      isSetPasswordLoading.value = false;
    } catch (e) {
      customSnackBar(
        title: 'Error',
        message: e.toString(),
        alertType: AlertType.alertError,
      );
    }
    isSetPasswordLoading.value = false;
  }
}
