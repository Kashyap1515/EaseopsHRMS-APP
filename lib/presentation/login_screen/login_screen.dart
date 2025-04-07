import 'package:easeops_hrms/app_export.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: symetricH16,
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      CustomText(
                        title: 'Please Log in to your account',
                        fontSize: fontLarge,
                        color: AppColors.textColor,
                      ),
                      sbh30,
                      CustomTextFormField(
                        inputHeight: 0,
                        textEditingController: controller.emailController,
                        hintText: 'Enter your email / mobile',
                        validatorCallback: validateEmailOrMobile,
                        suffixIcon: AppIcons.iconInfo,
                        contentPadding: symetricH16,
                      ),
                      sbh10,
                      CustomTextFormField(
                        inputHeight: 0,
                        textEditingController: controller.passwordController,
                        hintText: 'Enter Your Password',
                        validatorCallback: validatePwdData,
                        suffixIcon: controller.passwordToggleImage.value,
                        suffixCallBack: controller.visibilityToggle,
                        obscureText: controller.obscureText.value,
                        contentPadding: symetricH16,
                      ),
                      sbh10,
                      InkWell(
                        onTap: controller.btnForgotPwdPressed,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            title: 'Forgot Password?',
                            fontSize: fontTempLarge,
                            color: AppColors.primaryColor,
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      sbh30,
                      CustomButton(
                        btnText: 'Log In',
                        isLoading:
                            !!(controller.status.value == Status.loading),
                        callback: controller.btnLoginPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
