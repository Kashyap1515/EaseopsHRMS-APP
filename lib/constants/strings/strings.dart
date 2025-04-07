import 'package:easeops_hrms/utils/flavor_config.dart';

class AppStrings {
  static String appName = FlavorConfig.instance.values.appName;
  Flavor environment =
      FlavorConfig.isProduction() ? Flavor.production : Flavor.staging;
  static const String appTagline = 'AI-Powered Automation';
  static const String strUpdateProfile = 'Click Here to Update Profile Photo';
  static const String strUpdateUserSelfie = 'Update user profile';
  static const String strMarkAttendance = 'Mark Attendance';
  static const String strClickMarkAttendance = 'Click here to Mark Attendance';
  static const String textSuccess = 'Success';
  static const String textError = 'Oops..!!';
  static const String textErrorMessage =
      'Something went wrong. Please try again later..!!';
  static const String strOffline = 'You are offline!';
  static const String strNoInternetFound =
      'This feature requires an internet connection to function properly.';
}

enum AlertType { success, error, alertMessage, alertError }

enum RefType { Attendance, User }

List<Map<String, Object>> languageData = [
  {
    'name': 'English',
    'english_name': 'English',
    'language_code': 'en-IN',
  },
  {
    'name': 'हिंदी',
    'english_name': 'Hindi',
    'language_code': 'hi',
  },
  {
    'name': 'ಕನ್ನಡ',
    'english_name': 'Kannada',
    'language_code': 'kn',
  },
  {
    'name': 'عربي',
    'english_name': 'Arabic',
    'language_code': 'ar',
  },
  {
    'name': 'Français',
    'english_name': 'French',
    'language_code': 'fr',
  },
  {
    'name': 'Española',
    'english_name': 'Spanish',
    'language_code': 'es',
  }
];
