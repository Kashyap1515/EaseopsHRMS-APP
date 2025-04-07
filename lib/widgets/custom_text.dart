import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/utils/translate.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.title,
    this.fontSize,
    super.key,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing,
    this.color,
    this.shadow,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.isTranslated = false,
    this.isOriginal = false,
  });

  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final TextDecoration textDecoration;
  final List<Shadow>? shadow;
  final int? maxLines;
  final bool isTranslated;
  final bool isOriginal;

  Future<String> getTranslatedText() async {
    if (title.isEmpty || isOriginal) {
      return title;
    }
    return translateValue(text: title);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getTranslatedText(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            title,
            style: GoogleFonts.montserrat(
              shadows: shadow ?? [],
              color: color ?? AppColors.kcBlackColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              letterSpacing: letterSpacing,
              decoration: textDecoration,
            ),
            overflow: textOverflow,
            textAlign: textAlign,
            maxLines: maxLines,
          );
        } else if (snapshot.hasError) {
          return Text(
            title,
            style: GoogleFonts.montserrat(
              shadows: shadow ?? [],
              color: color ?? AppColors.kcBlackColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              letterSpacing: letterSpacing,
              decoration: textDecoration,
            ),
            overflow: textOverflow,
            textAlign: textAlign,
            maxLines: maxLines,
          );
        } else {
          return Text(
            snapshot.data ?? title,
            style: GoogleFonts.inter(
              shadows: shadow ?? [],
              color: color ?? AppColors.kcBlackColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              letterSpacing: letterSpacing,
              decoration: textDecoration,
            ),
            overflow: textOverflow,
            textAlign: textAlign,
            maxLines: maxLines,
          );
        }
      },
    );
  }
}
