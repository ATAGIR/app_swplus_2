
// ignore_for_file: avoid_print, use_build_context_synchronously, dead_code_catch_following_catch

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/services/errores.dart';
import '../utils/message.dart';


class CatService {

  static final CatService _catService = CatService._internal();
  final Dio _dio = Dio();
  String token = '';

  factory CatService(){
    return _catService;
  }
  CatService._internal(){
    _dio.options.baseUrl = 'http://infopro-api.swplus.com.mx/api/log/get_last';
    _dio.options.connectTimeout = 120000;
    _dio.options.receiveTimeout = 120000;
    _dio.options.receiveDataWhenStatusError = false;
    _dio.options.responseType = ResponseType.json;
  }



  Future<MedidorUser?> getLast(BuildContext context, String token) async {
    final medidoruser = Provider.of<MedidorUser>(context, listen: false);
    try {
      Message.show(context);
      final response = await _dio.request('medidor',
          data: {"token": token}, options: Options(method: 'GET'));
      print(response.data);
      if (response.statusCode == 200) {
        final MedidorUser medidorUser = MedidorUser.fromJson(response.data);
        if (token == token) {
          print(response.data);
        }
        Message.dissmiss(context);
        medidoruser.concesion = medidorUser as String;
        return medidorUser;
      } else {}
    } catch (e) {
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        print(e.response?.data);
        Message.dissmiss(context);
        Errores().showErrorMessage(e, context);

        return null;
      }
    }
    return null;
  }
}