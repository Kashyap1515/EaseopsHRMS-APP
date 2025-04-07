import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:network_info_plus/network_info_plus.dart' as ni;
import 'package:package_info_plus/package_info_plus.dart';

enum ApiName { login, profile, device }

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<Status> status = Status.completed.obs;
  final LoginRepository _loginRepository = LoginRepository();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  RxString passwordToggleImage = AppIcons.iconNotVisible.obs;
  String deviceId = '';
  String deviceType = '';
  String version = '';
  String buildNumber = '';
  String deviceOs = '';
  String deviceModel = '';

  String? emailAddress;
  String? mobileNoAddress;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Forget Password Click Event
  void btnForgotPwdPressed() {
    Get.toNamed<void>(RoutesName.forgetPasswordScreen);
  }

  static Future<String?> getWebFCMToken({int maxRetires = 3}) async {
    try {
      final token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BC7khrqGzLdYsArCl7rvYzV2PwM9-tuWNAoC9feuIqM1h-eqHHb6nc8kQNx8TJ3XHG0QrtEUYkEHpfmTJ8s7Lwo',
      );
      return token;
    } catch (e) {
      if (maxRetires > 0) {
        await Future.delayed(const Duration(seconds: 3), () {});
        return getWebFCMToken(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }

  Future<String?> getIpAddress() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi) {
        final info = ni.NetworkInfo();
        final ipAddress = await info.getWifiIP();
        return ipAddress;
      } else {
        return null;
      }
    } catch (e) {
      Logger.log('Failed to get IP address: $e');
    }
    return null;
  }

  Future<void> getFCMToken() async {
    if (kIsWeb) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
      deviceModel = deviceInfo.browserName.name;
      deviceOs = deviceInfo.platform ?? '';
      deviceType = 'Web';
      deviceId = await getWebFCMToken() ?? '';
      version = appVersion;
      buildNumber = appVersionCode.toString();
    } else {
      if (Platform.isAndroid) {
        final packageInfo = await PackageInfo.fromPlatform();
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
        await GetStorageHelper.addValue(GetStorageKeys.keyVersion, version);
        await GetStorageHelper.addValue(GetStorageKeys.keySdkInt, buildNumber);
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceOs = androidInfo.version.sdkInt.toString();
        deviceType = 'Android';
        await FirebaseMessaging.instance.getToken().then((newToken) {
          deviceId = newToken.toString();
        });
      } else if (Platform.isIOS) {
        final packageInfo = await PackageInfo.fromPlatform();
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.iosInfo;
        deviceModel = androidInfo.model;
        deviceOs = androidInfo.systemVersion;
        deviceType = 'Ios';
        await FirebaseMessaging.instance.getToken().then((newToken) {
          deviceId = newToken.toString();
        });
      }
    }
  }

  void visibilityToggle() {
    obscureText.value = !obscureText.value;
    if (obscureText.value) {
      passwordToggleImage.value = AppIcons.iconNotVisible;
    } else {
      passwordToggleImage.value = AppIcons.iconVisibility;
    }
  }

  // Login Button Click Event
  void btnLoginPressed() {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    loginFormKey.currentState!.save();

    final emailOrPhone = emailController.text.trim();

    if (emailOrPhone.contains('@') && emailOrPhone.contains('.')) {
      emailAddress = emailOrPhone;
      mobileNoAddress = null;
    } else {
      mobileNoAddress = emailOrPhone;
      emailAddress = null;
    }

    fetchAPIResponse(
      apiName: ApiName.login,
      jsonBody: <String, dynamic>{
        'password': passwordController.text.trim(),
        'email': emailAddress,
        'phone_number': mobileNoAddress,
      },
    );
  }

  Future<void> onLoginAPIResponse() async {
    final loginData = apiDataResult.data! as LoginModel;
    await GetStorageHelper.setUserData(jsonEncode(loginData));
    await fetchAPIResponse(apiName: ApiName.profile);
  }

  Future<void> onProfileAPIResponse() async {
    final profileData = apiDataResult.data! as UserLoggedInProfile;
    await GetStorageHelper.setProfileData(jsonEncode(profileData));
    final ipAddress = kIsWeb ? '' : await getIpAddress() ?? '';
    await fetchAPIResponse(
      apiName: ApiName.device,
      jsonBody: <String, dynamic>{
        'dev_id': deviceId,
        'reg_id': '',
        'is_active': true,
        'os': deviceType,
        'model': deviceModel,
        'os_version': deviceOs,
        'app_version_code': buildNumber,
        'app_version': version,
        'ip_address': ipAddress,
      },
    );
  }

  Future<void> onDeviceAPIResponse() async {
    await Get.offNamed<void>(
      RoutesName.locationChoice,
      arguments: {
        'isFromLogin': true,
      },
    );
  }

  ApiResponse<dynamic> apiDataResult = ApiResponse.loading();

  Future<void> _setApiDataResponse({
    required ApiName apiName,
    required ApiResponse<dynamic> response,
  }) async {
    Logger.log('API Result :-\n $response');
    apiDataResult = response;
    if (apiDataResult.status == Status.completed) {
      if (apiName == ApiName.login) {
        await onLoginAPIResponse();
      } else if (apiName == ApiName.profile) {
        await getFCMToken();
        await onProfileAPIResponse();
      } else if (apiName == ApiName.device) {
        await onDeviceAPIResponse();
      }
      status.value = Status.completed;
    } else if (apiDataResult.status == Status.error) {
      if (apiName == ApiName.device) {
        await onDeviceAPIResponse();
      }
      status.value = Status.completed;
      customSnackBar(
        title: 'Something went wrong..!!',
        message: apiDataResult.message.toString(),
        alertType: AlertType.alertError,
      );
    } else {
      status.value = Status.loading;
    }
  }

  Future<void> fetchAPIResponse({
    required ApiName apiName,
    Map<String, dynamic> jsonBody = const {},
  }) async {
    await _setApiDataResponse(
      apiName: apiName,
      response: ApiResponse.loading(),
    );
    await (apiName == ApiName.login
            ? _loginRepository.getLoginResponse(jsonBody)
            : apiName == ApiName.device
                ? _loginRepository.getDeviceRequest(jsonBody)
                : _loginRepository.getMyProfileRequest())
        .then(
          (value) => _setApiDataResponse(
            apiName: apiName,
            response: ApiResponse.completed(value),
          ),
        )
        .onError(
          (error, stackTrace) => _setApiDataResponse(
            apiName: apiName,
            response: ApiResponse.error(error.toString()),
          ),
        );
  }
}
