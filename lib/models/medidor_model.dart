// To parse this JSON data, do
//
//     final medidorDeUsuario = medidorDeUsuarioFromMap(jsonString);

// ignore_for_file: constant_identifier_names, unnecessary_null_comparison, file_names

import 'dart:convert';

class MedidorUser {
  MedidorUser({
    required this.psiId,
    required this.psi,
    required this.concesionId,
    required this.concesion,
    required this.rfc,
    required this.razonSocial,
    required this.logs,
  });

  int psiId;
  String psi;
  int? concesionId;
  String concesion;
  String rfc;
  String razonSocial;
  List<Log> logs;

  factory MedidorUser.fromJson(String str) =>
      MedidorUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedidorUser.fromMap(Map<String, dynamic> json) => MedidorUser(
        psiId: json["psi_id"],
        psi: json["psi"],
        concesionId: json["concesion_id"],
        concesion: json["concesion"],
        //concesion: json["concesion"] == null ? null : json["concesion"],
        rfc: json["rfc"],
        razonSocial: json["razon_social"],
        logs: List<Log>.from(json["logs"].map((x) => Log.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "psi_id": psiId,
        "psi": psi,
        "concesion_id": concesionId,
        "concesion": concesion,
        //"concesion": concesion == null ? null : concesion,
        "rfc": rfc,
        "razon_social": razonSocial,
        "logs": List<dynamic>.from(logs.map((x) => x.toMap())),
      };
}

class Log {
  Log({
    this.rfc,
    required this.nsm,
    required this.nsue,
    required this.lat,
    required this.long,
    this.modeloId,
    required this.modelo,
    required this.ccid,
    required this.imei,
    required this.nsut,
    required this.etiqueta,
    this.ker,
    required this.fecha,
    this.history,
  });

  Rfc? rfc;
  String nsm;
  String nsue;
  double lat;
  double long;
  int? modeloId;
  String modelo;
  String ccid;
  String imei;
  String nsut;
  String etiqueta;
  dynamic ker;
  DateTime fecha;
  dynamic history;

  factory Log.fromJson(String str) => Log.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Log.fromMap(Map<String, dynamic> json) => Log(
        rfc: rfcValues.map[json["rfc"]],
        nsm: json["nsm"],
        nsue: json["nsue"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        modeloId: json["modelo_id"],
        modelo: json["modelo"],
        ccid: json["ccid"],
        imei: json["imei"],
        nsut: json["nsut"],
        etiqueta: json["etiqueta"],
        ker: json["ker"],
        fecha: DateTime.parse(json["fecha"]),
        history: json["history"],
      );

  Map<String, dynamic> toMap() => {
        "rfc": rfcValues.reverse![rfc],
        "nsm": nsm,
        "nsue": nsue,
        "lat": lat,
        "long": long,
        "modelo_id": modeloId,
        "modelo": modelo,
        "ccid": ccid,
        "imei": imei,
        "nsut": nsut,
        "etiqueta": etiqueta,
        "ker": ker,
        "fecha": fecha.toIso8601String(),
        "history": history,
      };
}

enum Rfc { OCM200110_QR3, STE130213445 }

final rfcValues = EnumValues(
    {"OCM200110QR3": Rfc.OCM200110_QR3, "STE130213445": Rfc.STE130213445});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;
//aqui era el error
  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap == map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
