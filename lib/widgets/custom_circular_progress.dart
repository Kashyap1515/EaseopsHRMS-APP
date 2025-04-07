import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key, this.color});

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 18.h),
        child: CircularProgressIndicator(
          color: color ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}
