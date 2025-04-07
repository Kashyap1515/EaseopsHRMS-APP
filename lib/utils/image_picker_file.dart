// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:easeops_hrms/app_export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

Future<XFile?> customImagePicker({required ImageSource imageSource}) async {
  try {
    final selectedFile = await ImagePicker().pickImage(source: imageSource);
    if (selectedFile == null) return null;
    return selectedFile;
  } on PlatformException catch (err) {
    Logger.log(err.toString());
    return null;
  }
}

Future<Map<String, dynamic>> onImageUploadAPICall({
  required XFile file,
  required String refId,
  required String refName,
  bool isCompressed = true,
}) async {
  final apiService = NetworkApiService();
  final fileName = file.name.toLowerCase();
  final jsonBody = <String, dynamic>{
    'ref_name': refName,
    'ref_id': refId,
    'filename_w_ext': fileName,
  };
  try {
    final result = await apiService.postResponse(
      ApiEndPoints.getImageUrl,
      jsonBody,
    );
    if (result != null) {
      final imageKey = result['key'] as String;
      final imageAWSUrlEndpoint = result['url'] as String;
      final isSuccess = await pickAndUploadImageWithPut(
        imageKey: imageKey,
        imageAWSUrlEndpoint: imageAWSUrlEndpoint,
        file: file,
        isCompressed: isCompressed,
      );
      return {
        'key': imageKey,
        'url': imageAWSUrlEndpoint,
        'fileName': fileName,
        'isSuccess': isSuccess,
      };
    } else {
      await FirebaseCrashlytics.instance.log(
        'Failed to upload image(Response got null): $result',
      );
      customSnackBar(
        alertType: AlertType.alertError,
        title: 'Oops..!',
        message: 'Failed to upload image. Please try again later',
      );
      return {
        'isSuccess': false,
      };
    }
  } catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
    await FirebaseCrashlytics.instance.log('Failed to upload image: $e $s');
    customSnackBar(
      alertType: AlertType.alertError,
      title: 'Oops..!',
      message: 'Failed to upload image. Please try again later',
    );
    return {
      'isSuccess': false,
    };
  }
}

Future<bool> pickAndUploadImageWithPut({
  required XFile file,
  required String imageKey,
  required String imageAWSUrlEndpoint,
  bool isCompressed = true,
}) async {
  try {
    final compressedImage = isCompressed
        ? await compressImage(imageToCompress: File(file.path))
        : File(file.path);

    if (compressedImage == null) {
      Logger.log('Image compression failed');
      return false;
    }

    final request = http.Request('PUT', Uri.parse(imageAWSUrlEndpoint))
      ..bodyBytes = compressedImage.readAsBytesSync();
    final response = await http.Client().send(request);

    if (response.statusCode == 200) {
      Logger.log('Image uploaded successfully');
      return true;
    } else {
      Logger.log('Failed to upload image. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    Logger.log('Error picking/uploading image: $e');
    return false;
  }
}
