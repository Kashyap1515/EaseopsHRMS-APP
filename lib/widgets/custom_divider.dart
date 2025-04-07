import 'package:easeops_hrms/app_export.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({this.height, this.thickness, super.key});

  final double? height;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.kcBorderColor,
      height: height ?? 0,
      thickness: thickness ?? 1,
    );
  }
}
