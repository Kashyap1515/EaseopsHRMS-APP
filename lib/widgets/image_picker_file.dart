import 'dart:io';
import 'package:easeops_hrms/app_export.dart';

Future<File?> pickImageFromPhone(ImageSource imgSource) async {
  File? imageFile;
  try {
    final image =
        await ImagePicker().pickImage(source: imgSource, imageQuality: 100);
    if (image == null) return null;
    imageFile = File(image.path);
    final imageFile01 = await compressImage(imageToCompress: imageFile);
    return imageFile01;
  } on PlatformException catch (err) {
    Logger.log(err.toString());
  }
  return null;
}

Future<File?> compressImage({required File imageToCompress}) async {
  final imageSizeInBytes = imageToCompress.lengthSync();
  final imageSizeInKbs = imageSizeInBytes / 1024;
  var percentage = 100;
  if (imageSizeInKbs > 2000) {
    percentage = 20;
  } else if (imageSizeInKbs > 1000 && imageSizeInKbs < 2000) {
    percentage = 30;
  } else {
    percentage = 50;
  }
  // final path = await FlutterNativeImage.compressImage(
  //   imageToCompress.absolute.path,
  //   quality: 80,
  //   percentage: percentage,
  // );
  return imageToCompress;
}

Future<String> convertToUrl(File? imageFile) async {
  try {
    if (imageFile != null) {
      final fileName = imageFile.path;
      final destination = 'files/$fileName';
      Logger.log('DESTINATION: $destination');
    }
  } catch (e) {
    Logger.log('Something went wrong..!!:M $e');
  }
  return '';
}
