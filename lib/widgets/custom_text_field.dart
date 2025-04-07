import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.textEditingController,
    super.key,
    this.title,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.validatorCallback,
    this.onTapCallBack,
    this.onChangedCallBack,
    this.keyboardType,
    this.contentPadding,
    this.onEditingComplete,
    this.isReadOnly = false,
    this.autofocus = false,
    this.fillColor,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.suffixIconHeight,
    this.suffixIcon1Height,
    this.focusNode,
    this.errorStyle,
    this.inputHeight,
    this.maxLines,
    this.suffixIcon,
    this.suffixIcon1,
    this.suffixCallBack,
    this.suffixCallBack1,
    this.onFocusCallback,
    this.prefixIcon,
    this.prefixCallBack,
  });

  final String? title;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final Color? borderColor;
  final bool isReadOnly;
  final String? suffixIcon;
  final String? suffixIcon1;
  final String? prefixIcon;
  final VoidCallback? suffixCallBack;
  final VoidCallback? suffixCallBack1;
  final VoidCallback? prefixCallBack;
  final bool autofocus;
  final double? inputHeight;
  final double? suffixIconHeight;
  final Color? fillColor;
  final double? suffixIcon1Height;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FocusNode? focusNode;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validatorCallback;
  final String? Function(String?)? onChangedCallBack;
  final VoidCallback? onTapCallBack;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onFocusCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text.rich(
            TextSpan(
              children: [
                // Regular text without asterisks
                TextSpan(
                  text: (title ?? '').replaceAll('*', ''),
                  style: GoogleFonts.montserrat(
                    fontSize: fontLarge,
                    color: AppColors.textColor,
                  ),
                ),
                if ((title ?? '').contains('*'))
                  TextSpan(
                    text: '*',
                    style: GoogleFonts.montserrat(
                      fontSize: fontLarge,
                      color: AppColors.kcFailedColor,
                    ),
                  ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        if (title != null) SizedBox(height: 0.5.h),
        SizedBox(
          height: inputHeight == 0 ? null : inputHeight ?? inputFieldSize,
          child: Focus(
            onFocusChange: (value) {
              if (!value) {
                if (onFocusCallback != null) {
                  // ignore: prefer_null_aware_method_calls
                  onFocusCallback!();
                }
              }
            },
            child: TextFormField(
              initialValue: initialValue,
              obscureText: obscureText,
              autocorrect: false,
              autofocus: autofocus,
              focusNode: focusNode,
              controller: textEditingController,
              style: GoogleFonts.montserrat(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
              maxLines: maxLines ?? 1,
              readOnly: isReadOnly,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                filled: true,
                fillColor: fillColor ?? AppColors.kcWhiteColor,
                contentPadding: inputHeight == 0
                    ? maxLines != null
                        ? symetricH16.copyWith(top: 10, bottom: 10)
                        : symetricH16
                    : contentPadding ?? all16,
                isDense: true,
                hintText: hintText ?? 'Enter $title',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (suffixIcon != null)
                      InkWell(
                        onTap: suffixCallBack,
                        child: SvgPicture.asset(
                          suffixIcon.toString(),
                          height: suffixIconHeight,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    sbw5,
                    if (suffixIcon1 != null)
                      InkWell(
                        onTap: suffixCallBack1,
                        child: SvgPicture.asset(
                          suffixIcon1.toString(),
                          height: suffixIcon1Height,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    sbw10,
                  ],
                ),
                prefixIcon: prefixIcon != null
                    ? InkWell(
                        onTap: prefixCallBack,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 3),
                          child: SvgPicture.asset(
                            prefixIcon.toString(),
                            colorFilter: const ColorFilter.mode(
                              AppColors.primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : null,
                hintStyle: GoogleFonts.montserrat(
                  fontWeight: fontWeight ?? FontWeight.normal,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: br4,
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: br4,
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: br4,
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: br4,
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: br4,
                  borderSide: const BorderSide(color: AppColors.dangerColor),
                ),
                errorStyle: errorStyle ?? TextStyle(fontSize: fontSmall),
              ),
              validator: (text) {
                return validatorCallback!(text);
              },
              onTap: onTapCallBack,
              onChanged: onChangedCallBack,
              onEditingComplete: onEditingComplete,
            ),
          ),
        ),
      ],
    );
  }
}
