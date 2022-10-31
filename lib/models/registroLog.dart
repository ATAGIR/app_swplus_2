// To parse this JSON data, do
//
//     final registro = registroFromMap(jsonString);

import 'dart:convert';

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

    factory RegistroLog.fromJson(String str) =>
    RegistroLog.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegistroLog.fromMap(Map<String, dynamic> json) => RegistroLog(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "password": password,
        "email": email,
        "role_id": roleId,
    };
}
