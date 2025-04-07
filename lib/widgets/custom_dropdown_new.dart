// ignore_for_file: avoid_dynamic_calls

import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDropDownNew extends StatelessWidget {
  const CustomDropDownNew({
    required this.itemList,
    super.key,
    this.hintText,
    this.selectedItem,
    this.title,
    this.errorMsg = '',
    this.onTapCallback,
    this.padding,
    this.isMapList = false,
    this.fontSize,
    this.height = 50,
    this.width,
  });

  final String? hintText;
  final String? selectedItem;
  final bool isMapList;
  final String? title;
  final String errorMsg;
  final double height;
  final double? width;
  final double? fontSize;
  final EdgeInsets? padding;
  final List<dynamic> itemList;
  final void Function(dynamic)? onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CustomText(
            title: title ?? '',
            fontSize: fontLarge,
            color: AppColors.textColor,
          ),
        if (title != null) SizedBox(height: 0.5.h),
        SizedBox(
          width: width,
          height: height,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<dynamic>(
              isExpanded: true,
              value: selectedItem,
              hint: CustomText(
                title: hintText ?? '',
                color: AppColors.kcGreyColor,
                textOverflow: TextOverflow.ellipsis,
              ),
              items: itemList
                  .map(
                    (item) => DropdownMenuItem<dynamic>(
                      value: !isMapList ? item : item['label'] ?? '',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item['imagePath'] != null)
                            ClipOval(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                  item['imagePath'].toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      SvgPicture.asset(
                                    AppIcons.iconUserEditOutLined,
                                    width: 32,
                                    height: 32,
                                    // ignore: deprecated_member_use
                                    color: AppColors.kcGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          if (item['imagePath'] != null) sbw10,
                          Expanded(
                            child: CustomText(
                              title: (!isMapList ? item : item['label'] ?? '')
                                  .toString(),
                              fontSize: fontSize ?? 14,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        onTapCallback!(item);
                      },
                    ),
                  )
                  .toList(),
              onChanged: (var val) {},
              buttonStyleData: ButtonStyleData(
                overlayColor: WidgetStateProperty.all(
                  AppColors.primaryColor.withOpacity(0.3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.kcBorderColor),
                  borderRadius: br8,
                ),
                padding: padding,
                elevation: 0,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down),
                iconDisabledColor: Colors.black,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 160,
                elevation: 0,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: AppColors.kcBorderColor),
                ),
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(
                    AppColors.primaryColor.withOpacity(0.3),
                  ),
                  trackVisibility: WidgetStateProperty.all(true),
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all<double>(6),
                  thumbVisibility: WidgetStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                overlayColor: WidgetStatePropertyAll(
                  AppColors.primaryColor.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
