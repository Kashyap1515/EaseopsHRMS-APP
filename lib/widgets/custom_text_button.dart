import 'package:easeops_hrms/app_export.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
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
  });

  final String btnText;
  final VoidCallback? callback;
  final Color bgColor;
  final Color btnTextColor;
  final bool isOutLinedButton;
  final double? btnWidth;
  final double? btnHeight;
  final IconData? iconData;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        elevation: isOutLinedButton ? 0 : null,
        minimumSize: Size(
          btnWidth ?? double.infinity,
          btnHeight ?? inputFieldSize,
        ),
      ),
      onPressed: callback,
      child: CustomText(
        title: btnText,
        fontSize: fontSize ?? 14,
        color: btnTextColor,
        fontWeight: fontWeight ?? FontWeight.w700,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }
}
