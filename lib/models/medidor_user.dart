import 'dart:convert';

List<MedidorUser> medidorUserFromJson(String str) => List<MedidorUser>.from(
    json.decode(str).map((x) => MedidorUser.fromJson(x)));

String medidorUserToJson(List<MedidorUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedidorUser {
  MedidorUser({
    this.psiId,
    this.psi,
    this.concesionId,
    this.concesion,
    this.rfc,
    this.razonSocial,
    this.logs,
  });

  int? psiId;
  String? psi;
  int? concesionId;
  String? concesion;
  String? rfc;
  String? razonSocial;
  List<Log>? logs;

  factory MedidorUser.fromJson(Map<String, dynamic> json) => MedidorUser(
        psiId: json["psi_id"] ,
        psi: json["psi"] ,
        concesionId: json["concesion_id"] ,
        concesion: json["concesion"] ?? "",
        rfc: json["rfc"] ,
        razonSocial: json["razon_social"] ,
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "psi_id": psiId,
        "psi": psi,
        "concesion_id": concesionId,
        "concesion": concesion,
        "rfc": rfc,
        "razon_social": razonSocial,
        "logs": List<dynamic>.from(logs!.map((x) => x.toJson())),
      };
}



class Log {
  Log({
    this.rfc,
    this.nsm,
    this.nsue,
    this.lat,
    this.long,
    this.modeloId,
    this.modelo,
    this.ccid,
    this.imei,
    this.nsut,
    this.etiqueta,
    this.fecha,
    this.history,
  });

  String? rfc;
  String? nsm;
  String? nsue;
  dynamic lat;
  dynamic long;
  int? modeloId;
  String? modelo;
  String? ccid;
  String? imei;
  String? nsut;
  String? etiqueta;
  DateTime? fecha;
  dynamic history;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        rfc: json["rfc"] ,
        nsm: json["nsm"] ,
        nsue: json["nsue"] ,
        lat: json["lat"] ,
        long: json["long"] ,
        modeloId: json["modelo_id"] ,
        modelo: json["modelo"] ,
        ccid: json["ccid"] ,
        imei: json["imei"] ,
        nsut: json["nsut"] ,
        etiqueta: json["etiqueta"] ,
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        history: json["history"],
      );

  Map<String, dynamic> toJson() => {
        "rfc": rfc,
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
        "fecha": fecha == null ? null : fecha!.toIso8601String(),
        "history": history,
      };
}
