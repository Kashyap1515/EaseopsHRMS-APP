import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_info_plus/network_info_plus.dart' as ni;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tzdata;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'EaseOps',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (!kIsWeb) {
    await Get.find<RootController>().showNotification(message: message);
  } else {
    await Get.find<RootController>()
        .onNotificationTap(payload: jsonEncode(message.data));
  }
}

Future<void> firebaseMessagingForegroundHandler(RemoteMessage message) async {
  if (!kIsWeb) {
    await Get.find<RootController>().showNotification(message: message);
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

class RootController extends GetxController {
  RxBool isRoleChange = false.obs;
  RxInt currentIndex = 0.obs;
  FirebaseMessaging? messaging = !kIsWeb ? FirebaseMessaging.instance : null;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LoginRepository _loginRepository = LoginRepository();

  @override
  Future<void> onInit() async {
    tzdata.initializeTimeZones();
    await getLocalTimezone();
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (!kIsWeb) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initializationSettingsDarwin = DarwinInitializationSettings();

      const initSettings = InitializationSettings(
        android: android,
        iOS: initializationSettingsDarwin,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: selectNotification,
      );
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    }
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
    FirebaseMessaging.onMessageOpenedApp
        .listen(firebaseMessagingForegroundHandler);
    if (GetStorageHelper.getUserData().token != null) {
      await setFirebaseToken();
    }
    super.onInit();
  }

  //
  Future<void> showNotification({required RemoteMessage message}) async {
    Logger.log('Foreground message Data1: ${message.toMap()}');
    final notificationData = message.data;
    final jsonPayload = jsonEncode(notificationData);
    final androidChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      color: AppColors.primaryColor,
      icon: '@mipmap/launcher_icon',
      importance: Importance.high,
      priority: Priority.high,
      largeIcon: const FilePathAndroidBitmap(AppImages.appLogo),
    );
    final notificationDetails = NotificationDetails(
      android: androidChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: jsonPayload,
    );
  }

  Future<void> selectNotification(
    NotificationResponse notificationResponse,
  ) async {
    await onNotificationTap(payload: notificationResponse.payload);
  }

  Future<void> onNotificationTap({required String? payload}) async {}

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

  Future<void> setFirebaseToken() async {
    final messaging = FirebaseMessaging.instance;
    if (kIsWeb) {
      messaging.onTokenRefresh.listen((newToken) {
        getFCMToken(devId: newToken);
      });
    } else {
      await messaging.getToken().then((String? token) {
        getFCMToken(devId: token!);
      });
      messaging.onTokenRefresh.listen((newToken) {
        getFCMToken(devId: newToken);
      });
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

  Future<void> getFCMToken({required String devId}) async {
    var deviceId = '';
    var deviceType = '';
    var version = '';
    var buildNumber = '';
    var deviceOs = '';
    var deviceModel = '';
    final ipAddress = kIsWeb ? '' : await getIpAddress() ?? '';
    if (kIsWeb) {
      deviceType = 'Web';
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
      deviceModel = deviceInfo.browserName.name;
      deviceOs = deviceInfo.platform ?? '';
      version = appVersion;
      buildNumber = appVersionCode.toString();
      deviceId = devId;
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
        deviceId = devId;
      } else if (Platform.isIOS) {
        final packageInfo = await PackageInfo.fromPlatform();
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.iosInfo;
        deviceModel = androidInfo.model;
        deviceOs = androidInfo.systemVersion;
        deviceType = 'Ios';
        deviceId = devId;
      }
    }
    await fetchAPIResponse(
      jsonBody: {
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

  ApiResponse<dynamic> apiDataResult = ApiResponse.loading();

  Future<void> _setApiDataResponse({
    required ApiResponse<dynamic> response,
  }) async {
    Logger.log('API Result :-\n $response');
    apiDataResult = response;
    if (apiDataResult.status == Status.completed) {}
  }

  Future<void> fetchAPIResponse({
    required Map<String, dynamic> jsonBody,
  }) async {
    await _setApiDataResponse(
      response: ApiResponse.loading(),
    );
    await _loginRepository
        .getDeviceRequest(jsonBody)
        .then(
          (value) => _setApiDataResponse(
            response: ApiResponse.completed(value),
          ),
        )
        .onError(
          (error, stackTrace) => _setApiDataResponse(
            response: ApiResponse.error(error.toString()),
          ),
        );
  }
}
