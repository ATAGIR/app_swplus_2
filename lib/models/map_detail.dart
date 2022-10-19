// To parse this JSON data, do
//
//     final detalleMedidor = detalleMedidorFromJson(jsonString);

import 'dart:convert';

List<DetalleMedidor> getMedidorDetalleFromJson(String str) =>
    List<DetalleMedidor>.from(
        json.decode(str).map((x) => DetalleMedidor.fromJson(x)));

String getMedidorDetalleToJson(List<DetalleMedidor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetalleMedidor {
  DetalleMedidor({
    this.logId,
    this.tipoId,
    this.sistema,
    this.fecha,
    this.rfc,
    this.nsm,
    this.nsue,
    this.lat,
    this.long,
    this.gasto,
    this.vol,
    this.modeloId,
    this.modelo,
    this.ccid,
    this.imei,
    this.ker,
  });

  int? logId;
  int? tipoId;
  String? sistema;
  DateTime? fecha;
  String? rfc;
  String? nsm;
  String? nsue;
  int? lat;
  int? long;
  int? gasto;
  double? vol;
  int? modeloId;
  String? modelo;
  String? ccid;
  String? imei;
  dynamic? ker;

  factory DetalleMedidor.fromJson(Map<String, dynamic> json) => DetalleMedidor(
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
        vol: json["vol"].toDouble(),
        modeloId: json["modelo_id"],
        modelo: json["modelo"],
        ccid: json["ccid"],
        imei: json["imei"],
        ker: json["ker"],
      );

  Map<String, dynamic> toJson() => {
        "log_id": logId,
        "tipo_id": tipoId,
        "sistema": sistema,
        "fecha": fecha,
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
        "ker": ker,
      };
}
