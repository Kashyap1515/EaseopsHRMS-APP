import 'package:easeops_hrms/app_export.dart';

class InternalExceptionWidget extends StatelessWidget {
  const InternalExceptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sbh60,
        Center(child: Image.asset('assets/images/error_robot.png')),
        CustomText(
          title: 'Oops! Something Seems to be wrong!',
          fontSize: fontLarge,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
