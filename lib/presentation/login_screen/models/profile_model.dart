import 'dart:convert';

UserLoggedInProfile userLoggedInProfileFromJson(String str) =>
    UserLoggedInProfile.fromJson(json.decode(str) as Map<String, dynamic>);

String userLoggedInProfileToJson(UserLoggedInProfile data) =>
    json.encode(data.toJson());

class UserLoggedInProfile {
  UserLoggedInProfile({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.userAccountsDetails,
    this.s3Url,
  });

  factory UserLoggedInProfile.fromJson(Map<String, dynamic> json) =>
      UserLoggedInProfile(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        userAccountsDetails: json['user_accounts_details'] == null
            ? []
            : List<UserAccountsDetail>.from(
                (json['user_accounts_details'] as List<dynamic>).map(
                  (x) => UserAccountsDetail.fromJson(x as Map<String, dynamic>),
                ),
              ),
        s3Url: json['s3_url'] as String?,
      );
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  List<UserAccountsDetail>? userAccountsDetails;
  String? s3Url;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'user_accounts_details': userAccountsDetails == null
            ? <dynamic>[]
            : List<dynamic>.from(userAccountsDetails!.map((x) => x.toJson())),
        's3_url': s3Url,
      };
}

class UserAccountsDetail {
  UserAccountsDetail({
    this.id,
    this.name,
    this.privileges,
    this.abilities,
    this.geoFencedSubmission,
    this.geoRadius,
    this.extras,
  });

  factory UserAccountsDetail.fromJson(Map<String, dynamic> json) =>
      UserAccountsDetail(
        id: json['id'] as String?,
        name: json['name'] as String?,
        geoRadius: json['geo_radius'] as int?,
        geoFencedSubmission: json['geo_fence_submission'] as bool?,
        privileges: json['privileges'] == null
            ? []
            : List<String>.from(
                (json['privileges'] as List<dynamic>).map((x) => x),
              ),
        abilities: json['abilities'] == null
            ? []
            : List<String>.from(
                (json['abilities'] as List<dynamic>).map((x) => x),
              ),
        extras: json['extras'] == null
            ? null
            : Extras.fromJson(json['extras'] as Map<String, dynamic>),
      );

  String? id;
  String? name;
  List<String>? privileges;
  List<String>? abilities;
  bool? geoFencedSubmission;
  int? geoRadius;
  Extras? extras;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'geo_radius': geoRadius,
        'geo_fence_submission': geoFencedSubmission,
        'extras': extras?.toJson(),
        'privileges': privileges == null
            ? <dynamic>[]
            : List<dynamic>.from(privileges!.map((x) => x)),
        'abilities': abilities == null
            ? <dynamic>[]
            : List<dynamic>.from(abilities!.map((x) => x)),
      };
}

class Extras {
  Extras({
    this.actionColumns,
  });

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        actionColumns: json['action_columns'] == null
            ? []
            : List<dynamic>.from(
                (json['action_columns'] as List<dynamic>).map((x) => x),
              ),
      );
  List<dynamic>? actionColumns;

  Map<String, dynamic> toJson() => {
        'action_columns': actionColumns == null
            ? <dynamic>[]
            : List<dynamic>.from(actionColumns!.map((x) => x)),
      };
}
