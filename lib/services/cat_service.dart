// ignore_for_file: avoid_print, use_build_context_synchronously, dead_code_catch_following_catch

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:telemetria/api/configure_api.dart';
import 'package:telemetria/models/models.dart';

class CatService {
  static final CatService _catService = CatService.internal();

  factory CatService() {
    return _catService;
  }
  CatService.internal();
  final Dio _dio = Dio(ConfigureApi.options);

  Future<List<MedidorUser>?> getLast(BuildContext context, String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";

      final response =
          await _dio.request('get_last', options: Options(method: 'GET'));

      if (response.statusCode == 200) {
        List<MedidorUser> responseMedidorUser =
            medidorUserFromJson(response.data).toList();
        print(response.data);
        return responseMedidorUser;
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

  Future<List<MapDetail>?> getMapDetail(BuildContext context, String token,
      String? nsut, String? etiqueta, int? dias) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.request('get_detail',
          queryParameters: {"Nsut": nsut, "Etiqueta": etiqueta, "Dias": dias},
          options: Options(method: 'GET'));
      print(response);

      if (response.statusCode == 200) {
        final List<MapDetail> responseMapDetail =
            getMedidorDetalleFromJson(response.data);
        print(response.data);
        return responseMapDetail;
      }
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }
}
