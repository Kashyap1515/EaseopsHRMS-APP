// To parse this JSON data, do
//
//     final accountUserDataModel = accountUserDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:easeops_hrms/presentation/home_screen/model/attendance_report_user.dart';

List<AccountUserDataModel> accountUserDataModelFromJson(String str) =>
    List<AccountUserDataModel>.from(
        json.decode(str).map((x) => AccountUserDataModel.fromJson(x)));

String accountUserDataModelToJson(List<AccountUserDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountUserDataModel {
  String? id;
  String? name;
  String? displayPicture;
  String? email;
  dynamic phoneNumber;
  bool? isVerified;
  List<Role>? roles;
  List<Location>? locations;
  List<dynamic>? checklists;
  List<dynamic>? forms;
  List<dynamic>? assessments;
  dynamic departmentName;

  AccountUserDataModel({
    this.id,
    this.name,
    this.displayPicture,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.roles,
    this.locations,
  });

  factory AccountUserDataModel.fromJson(Map<String, dynamic> json) =>
      AccountUserDataModel(
        id: json["id"],
        name: json["name"],
        displayPicture: json["display_picture"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        isVerified: json["is_verified"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_picture": displayPicture,
        "email": email,
        "phone_number": phoneNumber,
        "is_verified": isVerified,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Role {
  String? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
