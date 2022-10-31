import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/registro_login.dart';
import 'package:telemetria/utils/message.dart';
import '../models/registroLog.dart';
import '../providers/registro_provider.dart';

class RegistroServ {
  static final RegistroServ _registroServ = RegistroServ._internal();
  final Dio _dio = Dio();

  factory RegistroServ(){
    return _registroServ;
  }
  RegistroServ._internal(){
    _dio.options.baseUrl = 'http://infopro-api.swplus.com.mx/api/auth/';
    _dio.options.connectTimeout = 120000;
    _dio.options.receiveTimeout = 120000;
    _dio.options.receiveDataWhenStatusError = false;

    _dio.options.responseType = ResponseType.plain;
  }

  Future<RegistroLogin?> registro(BuildContext context, String username,
      String email, String password) async {
        final registroLog = Provider.of<RegistroProvider>(context, listen: false);
      
      try{
        Message.show(context);
        final response = await _dio.request('register',
        data: {"username": username, "email": email, "password": password},
        options: Options(method: 'POST'));

        print(response.data);

        if (response.statusCode == 200){
          final RegistroLog registroLog = RegistroLog.fromJson(response.data);
        } else {
          return null;
        }
      } on DioError catch (e){
        if (e.response != null){
          print(e.response?.statusCode);
          print(e.response?.data);
          Message.dissmiss(context);

          return null;
        }
      }
      }
}