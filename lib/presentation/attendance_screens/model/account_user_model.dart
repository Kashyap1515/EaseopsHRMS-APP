// To parse this JSON data, do
//
//     final accountUserDataModel = accountUserDataModelFromJson(jsonString);

import 'dart:convert';

List<AccountUserDataModel> accountUserDataModelFromJson(String str) =>
    List<AccountUserDataModel>.from(
      (json.decode(str) as List).map(
        (x) => AccountUserDataModel.fromJson(x as Map<String, dynamic>),
      ) as Iterable<dynamic>,
    );

String accountUserDataModelToJson(List<AccountUserDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountUserDataModel {
  AccountUserDataModel({
    this.id,
    this.name,
    this.displayPicture,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.roles,
    this.locations,
    this.checklists,
    this.assessments,
    this.departmentName,
  });

  factory AccountUserDataModel.fromJson(Map<String, dynamic> json) =>
      AccountUserDataModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        displayPicture: json['display_picture'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        isVerified: json['is_verified'] as bool?,
        roles: json['roles'] == null
            ? []
            : List<dynamic>.from(
                (json['roles'] as List<dynamic>).map((x) => x),
              ),
        locations: json['locations'] == null
            ? []
            : List<dynamic>.from(
                (json['locations'] as List<dynamic>).map((x) => x),
              ),
        checklists: json['checklists'] == null
            ? []
            : List<dynamic>.from(
                (json['checklists'] as List<dynamic>).map((x) => x),
              ),
        assessments: json['assessments'] == null
            ? []
            : List<dynamic>.from(
                (json['assessments'] as List<dynamic>).map((x) => x),
              ),
        departmentName: json['department_name'] as String?,
      );

  String? id;
  String? name;
  String? displayPicture;
  String? email;
  String? phoneNumber;
  bool? isVerified;
  List<dynamic>? roles;
  List<dynamic>? locations;
  List<dynamic>? checklists;
  List<dynamic>? assessments;
  String? departmentName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_picture': displayPicture,
        'email': email,
        'phone_number': phoneNumber,
        'is_verified': isVerified,
        'roles': roles == null
            ? <dynamic>[]
            : List<dynamic>.from(roles!.map((x) => x)),
        'locations': locations == null
            ? <dynamic>[]
            : List<dynamic>.from(locations!.map((x) => x)),
        'checklists': checklists == null
            ? <dynamic>[]
            : List<dynamic>.from(checklists!.map((x) => x)),
        'assessments': assessments == null
            ? <dynamic>[]
            : List<dynamic>.from(assessments!.map((x) => x)),
        'department_name': departmentName,
      };
}
