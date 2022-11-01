// To parse this JSON data, do
//
//     final registroLog = registroLogFromMap(jsonString);

import 'dart:convert';

class RegistroLog {
    RegistroLog({
        this.username,
        this.password,
        this.email,
        this.roleId,
    });

    String? username;
    String? password;
    String? email;
    int? roleId;

    factory RegistroLog.fromJson(String str) => RegistroLog.fromMap(json.decode(str));

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
