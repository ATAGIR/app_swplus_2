// To parse this JSON data, do
//
//     final detalleMedidor = detalleMedidorFromMap(jsonString);

import 'dart:convert';

List<DetalleMedidor> detalleMedidorFromJson(String str) =>
    List<DetalleMedidor>.from(
        json.decode(str).map((x) => DetalleMedidor.fromJson(x)));

String detalleMedidorToJson(List<DetalleMedidor> data)=> json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));

class DetalleMedidor {
  DetalleMedidor({
    required this.logId,
    required this.tipoId,
    required this.sistema,
    required this.fecha,
    required this.rfc,
    required this.nsm,
    required this.nsue,
    required this.lat,
    required this.long,
    required this.gasto,
    required this.vol,
    required this.modeloId,
    required this.modelo,
    required this.ccid,
    required this.imei,
  });

  int logId;
  int tipoId;
  String sistema;
  DateTime fecha;
  String rfc;
  String nsm;
  String nsue;
  int lat;
  int long;
  int gasto;
  int vol;
  int modeloId;
  String modelo;
  String ccid;
  String imei;

  factory DetalleMedidor.fromJson(String str) =>
      DetalleMedidor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetalleMedidor.fromMap(Map<String, dynamic> json) => DetalleMedidor(
        logId: json["log_id"],
        tipoId: json["tipo_id"],
        sistema: json["sistema"],
        fecha: DateTime.parse(json["fecha"]),
        rfc: json["rfc"],
        nsm: json["nsm"],
        nsue: json["nsue"],
        lat: json["lat"],
        long: json["long"],
        gasto: json["gasto"],
        vol: json["vol"],
        modeloId: json["modelo_id"],
        modelo: json["modelo"],
        ccid: json["ccid"],
        imei: json["imei"],
      );

  Map<String, dynamic> toMap() => {
        "log_id": logId,
        "tipo_id": tipoId,
        "sistema": sistema,
        "fecha": fecha.toIso8601String(),
        "rfc": rfc,
        "nsm": nsm,
        "nsue": nsue,
        "lat": lat,
        "long": long,
        "gasto": gasto,
        "vol": vol,
        "modelo_id": modeloId,
        "modelo": modelo,
        "ccid": ccid,
        "imei": imei,
      };
}
