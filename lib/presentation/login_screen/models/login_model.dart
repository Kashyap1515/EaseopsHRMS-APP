import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str) as Map<String, dynamic>);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.id,
    this.isStaff,
    this.displayPicture,
    this.isVerified,
    this.password,
    this.createdAt,
    this.isActive,
    this.name,
    this.isSuperuser,
    this.lastLogin,
    this.email,
    this.updatedAt,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: (json['id'] ?? '') as String,
        displayPicture: (json['display_picture'] ?? '') as String,
        isStaff: (json['is_staff'] ?? false) as bool,
        isVerified: (json['is_verified'] ?? false) as bool,
        password: (json['password'] ?? '') as String,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        isActive: (json['is_active'] ?? false) as bool,
        name: (json['name'] ?? '') as String,
        isSuperuser: (json['is_superuser'] ?? false) as bool,
        lastLogin: json['last_login'],
        email: json['email'] as String?,
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        token: (json['token'] ?? '') as String,
      );
  String? id;
  bool? isStaff;
  bool? isVerified;
  String? password;
  DateTime? createdAt;
  bool? isActive;
  String? displayPicture;
  String? name;
  bool? isSuperuser;
  dynamic lastLogin;
  String? email;
  DateTime? updatedAt;
  String? token;

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_staff': isStaff,
        'is_verified': isVerified,
        'display_picture': displayPicture,
        'password': password,
        'created_at': createdAt?.toIso8601String(),
        'is_active': isActive,
        'name': name,
        'is_superuser': isSuperuser,
        'last_login': lastLogin,
        'email': email,
        'updated_at': updatedAt?.toIso8601String(),
        'token': token,
      };
}
