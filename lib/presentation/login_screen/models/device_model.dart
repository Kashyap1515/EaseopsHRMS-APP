// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

DeviceInfoModel deviceModelFromJson(String str) =>
    DeviceInfoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String deviceModelToJson(DeviceInfoModel data) => json.encode(data.toJson());

class DeviceInfoModel {
  DeviceInfoModel({
    this.devId,
    this.regId,
    this.isActive,
    this.os,
    this.model,
    this.osVersion,
    this.appVersionCode,
    this.appVersion,
    this.ipAddress,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      DeviceInfoModel(
        devId: json['dev_id'] as String?,
        regId: json['reg_id'] as String?,
        isActive: json['is_active'] as bool,
        os: json['os'] as String?,
        model: json['model'] as String?,
        osVersion: json['os_version'] as String?,
        appVersionCode: json['app_version_code'] as String?,
        appVersion: json['app_version'] as String?,
        ipAddress: json['ip_address'] as String?,
        id: json['id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        userId: json['user_id'] as String?,
      );
  String? devId;
  String? regId;
  bool? isActive;
  String? os;
  String? model;
  String? osVersion;
  String? appVersionCode;
  String? appVersion;
  String? ipAddress;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  Map<String, dynamic> toJson() => {
        'dev_id': devId,
        'reg_id': regId,
        'is_active': isActive,
        'os': os,
        'model': model,
        'os_version': osVersion,
        'app_version_code': appVersionCode,
        'app_version': appVersion,
        'ip_address': ipAddress,
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_id': userId,
      };
}
