// import 'dart:io';
//
// import 'package:easeops_hrms/app_export.dart';
// import 'package:http/http.dart' as http;
//
// Future<bool> uploadImageToS3(File imageFile, String url) async {
//   // final fileName =
//   //     'your_image.jpg'; // Specify the desired file name in the S3 bucket
//
//   // // Create a timestamp for the request (useful for browser caching)
//   // final timestamp = DateTime.now().toString();
//
//   // // Prepare headers for the HTTP request
//   // final headers = {
//   //   'x-amz-date': timestamp,
//   //   'Authorization': 'AWS $accessKey:$signature',
//   //   'x-amz-storage-class': 'STANDARD', // Adjust as needed
//   // };
//
//   // Read the image file
//   final imageBytes = await imageFile.readAsBytes();
//
//   // Send a PUT request to upload the image
//   final response = await http.put(Uri.parse(url), body: imageBytes);
//   Logger.log('RESPONSE CODE: ${response.statusCode}');
//   Logger.log('RESPONSE BODY: ${response.body}');
//
//   if (response.statusCode == 200) {
//     return true;
//     // print('Image uploaded successfully to S3.');
//   }
//   return false;
//   // print('Failed to upload image to S3: ${response.statusCode}');
// }
