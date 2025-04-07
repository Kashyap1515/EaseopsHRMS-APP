import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/main.dart';
import 'package:easeops_hrms/presentation/attendance_screens/model/account_user_model.dart';
import 'package:easeops_hrms/presentation/attendance_screens/model/image_upload_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class AttendanceController extends GetxController {
  final Rx<Status> cameraStatus = Status.completed.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<Status> attendanceStatus = Status.completed.obs;
  final Rx<Status> attendancePunchedStatus = Status.completed.obs;
  File? imageFile;
  Rx<CameraController> cameraController = CameraController(
    cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => const CameraDescription(
        name: '',
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 0,
      ),
    ),
    ResolutionPreset.max,
    enableAudio: false,
  ).obs;
  final NetworkApiService _apiService = NetworkApiService();

  RxBool isOnboardUser = false.obs;
  RxDouble userLat = 0.0.obs;
  RxDouble userLon = 0.0.obs;
  RxString locationAddress = ''.obs;

  // RxString selectedMarkType = ''.obs;
  RxList<XFile> imageFiles = <XFile>[].obs;
  RxList<String> createPunchImageList = <String>[].obs;
  RxList<Map<String, dynamic>> userListData = <Map<String, dynamic>>[].obs;
  RxString selectedUserId = ''.obs;
  RxString selectedUserName = ''.obs;

  Future<void> setInitialData() async {
    final locationId = GetStorageHelper.getCurrentLocationData() != null
        ? GetStorageHelper.getCurrentLocationData()!.locationId
        : '';
    attendanceStatus.value = Status.loading;
    if (locationId != '') {
      await _apiService
          .getResponse(
        ApiEndPoints.accountUsers,
      )
          .then((value) {
        if (value != null) {
          userListData.clear();
          selectedUserId.value = '';
          final attendanceData =
              accountUserDataModelFromJson(jsonEncode(value));
          var currLocId =
              GetStorageHelper.getCurrentLocationData()?.locationId ?? '';
          for (final data in attendanceData) {
            var locationIds = (data.locations ?? []).map((e) => e.id).toList();
            if (locationIds.contains(currLocId)) {
              userListData.add({
                'id': data.id,
                'label':
                    '${data.name ?? ''} (${data.email ?? data.phoneNumber ?? ''})',
                'imagePath': data.displayPicture ?? '',
              });
            }
          }
          attendanceStatus.value = Status.completed;
        } else {
          attendanceStatus.value = Status.completed;
        }
      });
    }
  }

  Future<void> setLocation() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 5),
        );
        userLat.value = position.latitude;
        userLon.value = position.longitude;
        final placeMarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        final place = placeMarks[0];
        locationAddress.value =
            '${place.street}, ${place.locality}, ${place.country}';
        Future.delayed(const Duration(seconds: 5), () {
          if (userLat.value == 0.0 && userLon.value == 0.0) {
            userLat.value = 0.0;
            userLon.value = 0.0;
            locationAddress.value = '-';
          }
        });
      } catch (e) {
        Future.delayed(const Duration(seconds: 5), () {
          if (userLat.value == 0.0 && userLon.value == 0.0) {
            userLat.value = 0.0;
            userLon.value = 0.0;
            locationAddress.value = '-';
          }
        });
        Logger.log('Error getting location: $e');
      }
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        if (userLat.value == 0.0 && userLon.value == 0.0) {
          userLat.value = 0.0;
          userLon.value = 0.0;
          locationAddress.value = '-';
        }
      });
      Logger.log('Location permission denied');
    }
  }

  Future<void> captureImage() async {
    try {
      if (!cameraController.value.value.isInitialized) {
        return;
      }
      final xFile = await cameraController.value.takePicture();
      imageFile = File(xFile.path);

      if (imageFile != null) {
        clearAllData();
        imageFiles.add(xFile);
        await Get.toNamed<void>(RoutesName.punchDetailScreen);
      } else {
        customSnackBar(
          title: AppStrings.textError,
          message: AppStrings.textErrorMessage,
          alertType: AlertType.alertError,
        );
      }
    } catch (e) {
      Logger.log('Error capturing image: $e');
    }
  }

  Future<void> onAttendanceButtonPressed() async {
    if (!isOnboardUser.value &&
        (GetStorageHelper.getProfileData()
                .userAccountsDetails!
                .first
                .geoFencedSubmission ??
            false)) {
      final isWithinRadius = withinRadius(
        userLatitude: userLat.value,
        userLongitude: userLon.value,
        locLatitude: double.parse(
          GetStorageHelper.getCurrentLocationData()!.lat.toString(),
        ),
        locLongitude: double.parse(
          GetStorageHelper.getCurrentLocationData()!.lon.toString(),
        ),
        radiusMeter: double.parse(
          (GetStorageHelper.getProfileData()
                      .userAccountsDetails!
                      .first
                      .geoRadius ??
                  100)
              .toString(),
        ),
      );
      if (!isWithinRadius) {
        customSnackBar(
          title: AppStrings.textError,
          message:
              'You are not at the location so you can not mark attendance.',
          alertType: AlertType.alertError,
        );
        return;
      }
    }
    final refId =
        isOnboardUser.value ? selectedUserId.value : const Uuid().v4();
    final refName = isOnboardUser.value
        ? RefType.User.toString().split('.').last
        : RefType.Attendance.toString().split('.').last;
    attendancePunchedStatus.value = Status.loading;
    if (imageFiles.isNotEmpty) {
      for (final image in imageFiles) {
        final isImageSuccess = ImageUploadModel.fromJson(
          await onImageUploadAPICall(
            file: image,
            refId: refId,
            refName: refName,
            isCompressed: !isOnboardUser.value,
          ),
        );
        if (isImageSuccess.isSuccess) {
          if (isImageSuccess.url != null) {
            final questionMarkIndex = isImageSuccess.url!.indexOf('?');
            if (questionMarkIndex != -1) {
              final contentData =
                  isImageSuccess.url!.substring(0, questionMarkIndex);
              createPunchImageList.add(contentData);
            }
          } else {
            customSnackBar(
              title: AppStrings.textError,
              message: AppStrings.textErrorMessage,
              alertType: AlertType.alertError,
            );
            attendancePunchedStatus.value = Status.completed;
            return;
          }
        } else {
          customSnackBar(
            title: AppStrings.textError,
            message: AppStrings.textErrorMessage,
            alertType: AlertType.alertError,
          );
          attendancePunchedStatus.value = Status.completed;
          return;
        }
      }
    }
    if (createPunchImageList.isNotEmpty) {
      if (isOnboardUser.value) {
        await onSetDpAPIData();
      } else {
        await markPunchProcessAPIData(selectedAttendanceId: refId);
      }
    } else {
      customSnackBar(
        title: AppStrings.textError,
        message: 'Image is not uploaded properly. Please try again.',
        alertType: AlertType.alertError,
      );
    }
  }

  Future<void> markPunchProcessAPIData({
    required String selectedAttendanceId,
  }) async {
    if (!await NetworkInfo().isConnected()) {
      customSnackBar(
        title: AppStrings.strOffline,
        message: AppStrings.strNoInternetFound,
        alertType: AlertType.error,
      );
      return;
    }
    final locationId = GetStorageHelper.getCurrentLocationData() != null
        ? GetStorageHelper.getCurrentLocationData()!.locationId
        : '';
    final currentDateInUtc = DateTime.now().toUtc();
    final jsonBody = {
      'id': selectedAttendanceId,
      's3_url': createPunchImageList.toList().first,
      'event_coordinates': [userLat.value.toString(), userLon.value.toString()],
      'event_dt': currentDateInUtc.toString(),
      'location_id': locationId,
    };
    await _apiService
        .postResponse(
      ApiEndPoints.apiAttendanceProcess,
      jsonBody,
    )
        .then((value) async {
      if (value != null) {
        clearAllData();
        attendancePunchedStatus.value = Status.completed;
        Get.back<void>();
        customSnackBar(
          title: 'Success',
          message: 'You have Successfully upload your image.',
        );
      } else {
        attendancePunchedStatus.value = Status.completed;
        customSnackBar(
          title: 'Error',
          message: 'Something went wrong!',
          alertType: AlertType.alertError,
        );
        return;
      }
    }).catchError((err) {
      attendancePunchedStatus.value = Status.completed;
      customSnackBar(
        title: 'Error',
        message: 'Something went wrong!',
        alertType: AlertType.alertError,
      );
      return;
    });
  }

  Future<void> onSetDpAPIData() async {
    if (!await NetworkInfo().isConnected()) {
      customSnackBar(
        title: AppStrings.strOffline,
        message: AppStrings.strNoInternetFound,
        alertType: AlertType.error,
      );
      return;
    }
    final jsonBody = {
      'display_picture': createPunchImageList.toList().first,
    };
    await _apiService
        .patchResponse(
      '${ApiEndPoints.accountUsers}/${selectedUserId.value}/${ApiEndPoints.exApiSetDp}',
      jsonBody,
      isBoolReturn: true,
    )
        .then((value) async {
      if (value == true) {
        clearAllData();
        attendancePunchedStatus.value = Status.completed;
        Get.back<void>();
        customSnackBar(
          title: 'Success',
          message: '${AppStrings.strUpdateUserSelfie} Successfully.',
        );
      } else {
        attendancePunchedStatus.value = Status.completed;
        customSnackBar(
          title: 'Error',
          message: 'Something went wrong!',
          alertType: AlertType.alertError,
        );
        return;
      }
    }).catchError((err) {
      attendancePunchedStatus.value = Status.completed;
      customSnackBar(
        title: 'Error',
        message: 'Something went wrong!',
        alertType: AlertType.alertError,
      );
      return;
    });
  }

  void clearAllData() {
    imageFiles.clear();
    createPunchImageList.clear();
    isOnboardUser.value = false;
  }
}
