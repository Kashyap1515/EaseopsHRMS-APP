import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/set_password_screen/set_password_controller.dart';
import 'package:flutter/gestures.dart';

class SetPasswordScreen extends GetWidget<SetPasswordController> {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: GetBuilder(
          init: controller,
          initState: (state) {},
          builder: (context) {
            return Obx(
              () => Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: symetricH16,
                    child: Form(
                      key: controller.setPasswordForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // CustomText(
                          //   title: AppStrings.appName,
                          //   fontSize: 36,
                          //   fontWeight: FontWeight.w600,
                          //   color: AppColors.primaryColor,
                          // ),
                          SvgPicture.asset(
                            AppImages.appLogo,
                            width: Get.size.width / 1.5,
                          ),
                          sbh5,
                          const CustomText(
                            title: AppStrings.appTagline,
                            fontSize: 14,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          sbh60,
                          if (controller.allOKToNavigateLogin.value)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  title:
                                      'You have successfully created your new password.',
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Click here to go to the ',
                                    children: [
                                      TextSpan(
                                        text: ' Login ',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.offAllNamed<void>(
                                              RoutesName.loginScreen,
                                            );
                                          },
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' page.',
                                        style: GoogleFonts.montserrat(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  title: 'Create New Password',
                                  fontSize: fontLarge,
                                  color: AppColors.textColor,
                                ),
                                sbh30,
                                CustomTextFormField(
                                  inputHeight: 0,
                                  hintText: 'Password',
                                  textEditingController:
                                      controller.passwordController,
                                  suffixIcon: controller
                                      .passwordToggleImagePassword.value,
                                  suffixCallBack: () {
                                    controller.visibilityToggle(
                                      isPassword: true,
                                    );
                                  },
                                  obscureText:
                                      controller.obscureTextPassword.value,
                                  validatorCallback: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter your Password';
                                    } else if (value.length < 7) {
                                      return 'For Strong Password Length Must be Min 8 Characters';
                                    }
                                    return null;
                                  },
                                ),
                                sbh10,
                                CustomTextFormField(
                                  inputHeight: 0,
                                  hintText: 'Confirm Password',
                                  textEditingController:
                                      controller.confirmPasswordController,
                                  suffixIcon: controller
                                      .passwordToggleImageConfirmPassword.value,
                                  suffixCallBack: () {
                                    controller.visibilityToggle();
                                  },
                                  obscureText: controller
                                      .obscureTextConfirmPassword.value,
                                  validatorCallback: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Re-Enter your Confirm Password';
                                    } else if (controller
                                        .confirmPasswordController
                                        .text
                                        .isEmpty) {
                                      return 'Please enter confirm password field first';
                                    } else if (controller
                                            .passwordController.text !=
                                        value) {
                                      return 'Confirm Password not matching. Enter password again!';
                                    }
                                    return null;
                                  },
                                ),
                                sbh30,
                                CustomButton(
                                  btnText: 'Set Password',
                                  isLoading:
                                      controller.isSetPasswordLoading.value,
                                  callback: () async {
                                    await controller.saveForm(Get.context!);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
