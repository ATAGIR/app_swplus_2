// ignore_for_file: unused_field, prefer_final_fields, duplicate_ignore, unused_import, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:telemetria/data/models/medidor_model.dart';

class CatalogoService with ChangeNotifier {
  late MedidorModel _medidorDeUsuario;
  MedidorModel get medidorDeUsuario => _medidorDeUsuario;

  bool get existeMedidor => _medidorDeUsuario != null ? true : false;
}



// class CatServApi {
//   static final CatServApi _catServApi = CatServApi._internal();
//   final Dio _dio = Dio();
//   String token = "";

//   factory CatServApi() {
//     return _catServApi;
//   }
//   CatServApi._internal() {
//     _dio.options.baseUrl = 'http://infopro-api.swplus.com.mx/api/log/get_last';
//     _dio.options.connectTimeout = 120000;
//     _dio.options.receiveTimeout = 120000;
//     _dio.options.receiveDataWhenStatusError = false;
//     _dio.options.responseType = ResponseType.plain;
//   }
// }
