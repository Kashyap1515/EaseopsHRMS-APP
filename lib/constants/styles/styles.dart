import 'package:easeops_hrms/app_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Different Border radius
double fontSmall = 12;
double fontSmallMedium = 13;
double fontBase = 14;
double fontTempLarge = 15;
double fontLarge = 16;
double fontHeader6 = 18;
double fontHeader5 = 20;
double fontHeader4 = 22;

// Different Border radius
double inputFieldSize = 45;

// Different Border radius
BorderRadius br2 = BorderRadius.circular(2);
BorderRadius br3 = BorderRadius.circular(3);
BorderRadius br4 = BorderRadius.circular(4);
BorderRadius br8 = BorderRadius.circular(8);
BorderRadius br10 = BorderRadius.circular(10);

// Different radius
Radius r3 = const Radius.circular(3);
Radius r8 = const Radius.circular(8);
Radius r16 = const Radius.circular(16);
Radius r10 = const Radius.circular(10);

Border borderAll = Border.all(color: AppColors.borderColor);

// App Padding
EdgeInsets all3 = const EdgeInsets.all(3);
EdgeInsets all5 = const EdgeInsets.all(5);
EdgeInsets all10 = const EdgeInsets.all(10);
EdgeInsets all12 = const EdgeInsets.all(12);
EdgeInsets all16 = const EdgeInsets.all(16);
EdgeInsets symetricH5 = const EdgeInsets.symmetric(horizontal: 10);
EdgeInsets symetricH10 = const EdgeInsets.symmetric(horizontal: 10);
EdgeInsets symetricV7 = const EdgeInsets.symmetric(vertical: 7);
EdgeInsets symetricV10 = const EdgeInsets.symmetric(vertical: 10);
EdgeInsets symetricH16 = const EdgeInsets.symmetric(horizontal: 16);
EdgeInsets symetricH20 = const EdgeInsets.symmetric(horizontal: 20);
EdgeInsets containerPadding =
    EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 6.w);
EdgeInsets symetricH6 = EdgeInsets.symmetric(horizontal: 6.w);
EdgeInsets appHMargin = EdgeInsets.symmetric(horizontal: 4.w);
EdgeInsets appVMargin = EdgeInsets.symmetric(vertical: 4.w);
EdgeInsets appAllMargin = EdgeInsets.all(4.w);
EdgeInsets bottomBarPadding =
    EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w).copyWith(bottom: 3.h);

// Different SizedBox Height
SizedBox sbh1 = const SizedBox(height: 1);
SizedBox sbh3 = const SizedBox(height: 3);
SizedBox sbh5 = const SizedBox(height: 5);
SizedBox sbh8 = const SizedBox(height: 8);
SizedBox sbh10 = const SizedBox(height: 10);
SizedBox sbh14 = const SizedBox(height: 14);
SizedBox sbh16 = const SizedBox(height: 16);
SizedBox sbh20 = const SizedBox(height: 20);
SizedBox sbh30 = const SizedBox(height: 30);
SizedBox sbh60 = const SizedBox(height: 60);

// Different SizedBox Width
SizedBox sbw5 = const SizedBox(width: 5);
SizedBox sbw10 = const SizedBox(width: 10);
SizedBox sbw16 = const SizedBox(width: 16);
SizedBox sbw20 = const SizedBox(width: 20);
SizedBox sbw30 = const SizedBox(width: 30);
SizedBox sbw32 = const SizedBox(width: 32);

class Styles {
  static ThemeData removeDefaultSplash = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}

Decoration boxDecorationWithShadow = BoxDecoration(
  color: AppColors.kcWhiteColor,
  borderRadius: br8,
  border: Border.all(color: AppColors.kcBorderColor),
  boxShadow: const [
    BoxShadow(
      color: AppColors.kcBorderColor,
      blurRadius: 2,
      offset: Offset(1, 2),
    ),
  ],
);
