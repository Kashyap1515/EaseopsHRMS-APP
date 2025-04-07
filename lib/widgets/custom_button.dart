import 'package:easeops_hrms/app_export.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.btnText,
    required this.callback,
    super.key,
    this.btnTextColor = Colors.white,
    this.bgColor = AppColors.primaryColor,
    this.iconData,
    this.btnWidth,
    this.btnHeight,
    this.fontSize,
    this.fontWeight,
    this.isOutLinedButton = false,
    this.isLoading = false,
  });

  final String btnText;
  final VoidCallback? callback;
  final Color bgColor;
  final Color btnTextColor;
  final bool isOutLinedButton;
  final bool isLoading;
  final double? btnWidth;
  final double? btnHeight;
  final IconData? iconData;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        backgroundColor: isOutLinedButton ? Colors.transparent : bgColor,
        elevation: isOutLinedButton ? 0 : null,
        shape: RoundedRectangleBorder(
          borderRadius: br8,
          side: isOutLinedButton
              ? BorderSide(
                  color: bgColor,
                  width: 1.5,
                )
              : BorderSide.none,
        ),
        minimumSize: Size(
          btnWidth ?? double.infinity,
          btnHeight ?? inputFieldSize,
        ),
      ),
      onPressed: callback,
      child: isLoading
          ? const Center(
              child: FittedBox(
                child: CircularProgressIndicator(
                  color: AppColors.kcWhiteColor,
                ),
              ),
            )
          : CustomText(
              title: btnText,
              fontSize: fontSize ?? 14,
              color: isOutLinedButton ? bgColor : btnTextColor,
              fontWeight: fontWeight ?? FontWeight.w700,
              textOverflow: TextOverflow.ellipsis,
            ),
    );
  }
}
