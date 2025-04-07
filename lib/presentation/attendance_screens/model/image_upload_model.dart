// To parse this JSON data, do
//
//     final imageUploadModel = imageUploadModelFromJson(jsonString);

import 'dart:convert';

ImageUploadModel imageUploadModelFromJson(String str) =>
    ImageUploadModel.fromJson(json.decode(str) as Map<String, dynamic>);

String imageUploadModelToJson(ImageUploadModel data) =>
    json.encode(data.toJson());

class ImageUploadModel {
  ImageUploadModel({
    this.key,
    this.url,
    this.fileName,
    this.isSuccess = false,
  });

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) =>
      ImageUploadModel(
        key: json['key'] as String?,
        url: json['url'] as String?,
        fileName: json['fileName'] as String?,
        isSuccess: json['isSuccess'] as bool? ?? false,
      );
  String? key;
  String? url;
  String? fileName;
  bool isSuccess;

  Map<String, dynamic> toJson() =>
      {'key': key, 'url': url, 'fileName': fileName, 'isSuccess': isSuccess};
}
