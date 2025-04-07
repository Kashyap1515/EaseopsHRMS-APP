import 'package:easeops_hrms/app_export.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    required this.menuList,
    super.key,
    this.onSelected,
    this.icon,
  });

  final void Function(String)? onSelected;
  final List<String> menuList;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColors.kcWhiteColor,
      elevation: 0,
      shadowColor: AppColors.kcBlackColor,
      splashRadius: 5,
      shape: RoundedRectangleBorder(
        borderRadius: br8,
        side: const BorderSide(color: AppColors.kcBorderColor),
      ),
      icon: icon,
      position: PopupMenuPosition.under,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          for (final menuItem in menuList)
            PopupMenuItem(
              padding: const EdgeInsets.only(left: 12, right: 18),
              value: menuItem,
              child: CustomText(title: menuItem),
            ),
        ];
      },
    );
  }
}
