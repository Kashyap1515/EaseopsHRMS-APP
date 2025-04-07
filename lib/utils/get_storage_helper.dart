import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/language_choice_model.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';

class GetStorageKeys {
  static const String keyUserRole = 'keyUserRole';
  static const String keyUserData = 'keyUserData';
  static const String keyProcessTypeData = 'keyProcessTypeData';
  static const String keyVersion = 'keyVersion';
  static const String keySdkInt = 'keySdkInt';
  static const String keyProfileData = 'keyProfileData';
  static const String keyLocationData = 'keyLocationData';
  static const String keyLanguageData = 'keyLanguageData';
}

class GetStorageHelper {
  static Future<void> addValue(String key, dynamic value) async {
    await GetStorage().write(key, value);
  }

  static dynamic getValue(String key) {
    return GetStorage().read<dynamic>(key);
  }

  static Future<void> removeValue(String key) async {
    await GetStorage().remove(key);
  }

  static LoginModel getUserData() {
    final loginData = GetStorage().read<String>(GetStorageKeys.keyUserData);
    if (loginData != null) {
      return LoginModel.fromJson(
        json.decode(loginData) as Map<String, dynamic>,
      );
    } else {
      return LoginModel();
    }
  }

  static Future<void> setUserData(String value) {
    return GetStorage().write(GetStorageKeys.keyUserData, value);
  }

  static UserLoggedInProfile getProfileData() {
    final profileData =
        GetStorage().read<String>(GetStorageKeys.keyProfileData);
    if (profileData != null) {
      return UserLoggedInProfile.fromJson(
        json.decode(profileData) as Map<String, dynamic>,
      );
    } else {
      return UserLoggedInProfile();
    }
  }

  static Future<void> setProfileData(String value) {
    return GetStorage().write(GetStorageKeys.keyProfileData, value);
  }

  static ChecklistLocationModel? getCurrentLocationData() {
    final locationData =
        GetStorage().read<String>(GetStorageKeys.keyLocationData);
    if (locationData != null) {
      return ChecklistLocationModel.fromJson(
        json.decode(locationData) as Map<String, dynamic>,
      );
    } else {
      return null;
    }
  }

  static Future<void> setCurrentLocationData(String value) {
    return GetStorage().write(GetStorageKeys.keyLocationData, value);
  }

  static LanguageModel? getCurrentLanguageData() {
    final locationData =
        GetStorage().read<String>(GetStorageKeys.keyLanguageData);
    if (locationData != null) {
      return LanguageModel.fromJson(
        json.decode(locationData) as Map<String, dynamic>,
      );
    } else {
      return null;
    }
  }

  static Future<void> setCurrentLanguageData(String value) {
    return GetStorage().write(GetStorageKeys.keyLanguageData, value);
  }

  static Future<void> clearAll() async {
    await GetStorage().erase();
  }
}
