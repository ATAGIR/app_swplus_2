// ignore_for_file: file_names

import 'dart:convert';

List<RegistroLog> registroUsrFromJson(String str) => List<RegistroLog>.from(
    json.decode(str).map((x) => RegistroLog.fromJson(x)));

String registroUsrToJson(List<RegistroLog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegistroLog {
    RegistroLog({
        required this.username,
        required this.password,
        required this.email,
        required this.roleId,
    });

    String username;
    String password;
    String email;
    int roleId;

    factory RegistroLog.fromJson(Map<String, dynamic> json) => RegistroLog(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "role_id": roleId,
    };
}
