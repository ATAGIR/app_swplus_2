// ignore_for_file: avoid_print, use_build_context_synchronously, dead_code_catch_following_catch

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/services/errores.dart';

class CatService {
  static final CatService _catService = CatService._internal();
  final Dio _dio = Dio();
  String token = '';

  factory CatService() {
    return _catService;
  }
  CatService._internal() {
    _dio.options.baseUrl = 'http://infopro-api.swplus.com.mx/api/log/';
    _dio.options.connectTimeout = 120000;
    _dio.options.receiveTimeout = 120000;
    _dio.options.receiveDataWhenStatusError = false;
    _dio.options.responseType = ResponseType.json;
  }

  Future<MedidorUser?> getLast(BuildContext context, String token) async {
    try {
      _dio.options.headers["Autorization"] = "Bearer $token";
      // final medidoruser = Provider.of<MedidorUser>(context, listen: false);
      //Message.show(context);
      print(token);
      final response =
          await _dio.request('get_last', options: Options(method: 'GET'));

      if (response.statusCode == 200) {
        final MedidorUser medidorUser = MedidorUser.fromJson(response.data);
        print(medidorUser.razonSocial);
        // Message.dissmiss(context);

        return medidorUser;
      } else {}
    } on DioError catch (e) {
      print(e);
      if (e.response != null) {
        print(e.response?.statusCode);
        print(e.response?.data);
        //Message.dissmiss(context);
        return null;
      }
    }
    return null;
  }
}
