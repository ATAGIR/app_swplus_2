// To parse this JSON data, do
//
//     final loginPefil = loginPefilFromMap(jsonString);

import 'dart:convert';

class LoginPerfil {
  LoginPerfil({
    required this.userId,
    required this.userGui,
    required this.username,
    required this.roleId,
    required this.role,
    required this.email,
    this.emailConfirmed,
    required this.isActive,
    required this.token,
  });

  int userId;
  String userGui;
  String username;
  int roleId;
  String role;
  String email;
  bool? emailConfirmed;
  bool isActive;
  dynamic lastLogin;
  String token;

  factory LoginPerfil.fromJson(String str) =>
      LoginPerfil.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginPerfil.fromMap(Map<String, dynamic> json) => LoginPerfil(
        userId: json["user_id"],
        userGui: json["user_gui"],
        username: json["username"],
        roleId: json["role_id"],
        role: json["role"],
        email: json["email"],
        emailConfirmed: json["email_confirmed"],
        isActive: json["is_active"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "user_gui": userGui,
        "username": username,
        "role_id": roleId,
        "role": role,
        "email": email,
        "email_confirmed": emailConfirmed,
        "is_active": isActive,
        "last_login": lastLogin,
        "token": token,
      };
}
