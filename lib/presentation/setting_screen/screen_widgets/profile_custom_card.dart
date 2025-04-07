import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileCustomCard extends StatelessWidget {
  const ProfileCustomCard({
    required this.itemIcon,
    required this.itemTitle,
    required this.onItemTapped,
    this.isSuffixIcon = true,
    this.isTranslated = false,
    super.key,
  });

  final String itemIcon;
  final String itemTitle;
  final VoidCallback onItemTapped;
  final bool isSuffixIcon;
  final bool isTranslated;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTapped,
      child: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: Row(
          children: [
            SvgPicture.asset(
              itemIcon,
              width: 3.w,
              height: 3.h,
              // ignore: deprecated_member_use
              color: AppColors.kcBlackColor,
            ),
            SizedBox(width: 4.0.w),
            Expanded(
              child: CustomText(
                title: itemTitle,
                isTranslated: isTranslated,
                fontSize: fontTempLarge,
                color: AppColors.kcBlackColor,
              ),
            ),
            if (isSuffixIcon)
              SvgPicture.asset(
                AppIcons.iconRightArrow,
                width: 3.w,
                height: 3.h,
              ),
          ],
        ),
      ),
    );
  }
}
