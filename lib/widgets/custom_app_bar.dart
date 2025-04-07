import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

PreferredSizeWidget? customAppBar({
  required String title,
  VoidCallback? callback,
  Widget? titleWidget,
  String? imageIcon,
  VoidCallback? callback1,
  String? imageIcon1,
  double? elevation,
  Color? backgroundColor,
  Color? titleColor,
  Color? imageIcon1Color,
  List<Widget>? actions,
  PreferredSizeWidget? bottomWidget,
  bool automaticallyImplyLeading = false,
  bool isTranslated = false,
  double? height,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 55),
    child: AppBar(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: false,
      titleSpacing: 0,
      bottomOpacity: 0,
      bottom: bottomWidget,
      title: titleWidget ??
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: automaticallyImplyLeading ? 0.h : 1.h,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (imageIcon != null)
                  Theme(
                    data: Styles.removeDefaultSplash,
                    child: InkWell(
                      onTap: callback,
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: SvgPicture.asset(
                          imageIcon,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            imageIcon1Color ?? AppColors.kcWhiteColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  automaticallyImplyLeading ? const SizedBox() : sbw30,
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: CustomText(
                      title: title,
                      fontSize: fontHeader5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kcWhiteColor,
                      isTranslated: isTranslated,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
      actions: actions ??
          [
            if (imageIcon1 != null)
              InkWell(
                onTap: callback1,
                child: Container(
                  margin: EdgeInsets.all(2.w).copyWith(right: 5.w),
                  width: 28,
                  height: 28,
                  child: SvgPicture.asset(
                    imageIcon1,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      imageIcon1Color ?? AppColors.kcWhiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
    ),
  );
}
