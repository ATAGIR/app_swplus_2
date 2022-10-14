// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/perfil.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/errores.dart';
import '../utils/message.dart';
import '../utils/secure_storage.dart';

class AutService {
  static final AutService _autService = AutService._internal();
  final Dio _dio = Dio();
  String token = '';

  factory AutService() {
    return _autService;
  }
  AutService._internal() {
    _dio.options.baseUrl = 'http://infopro-api.swplus.com.mx/api/auth/';
    _dio.options.connectTimeout = 120000;
    _dio.options.receiveTimeout = 120000;
    _dio.options.receiveDataWhenStatusError = false;

    _dio.options.responseType = ResponseType.plain;
  }

  Future<LoginPerfil?> emailLogin(BuildContext context, String email,
      String password, bool saveSession) async {
    final loginperfil = Provider.of<LoginProvider>(context, listen: false);

    try {
      Message.show(context);
      final response = await _dio.request('login',
          data: {"username": email, "password": password},
          options: Options(method: 'POST'));

      print(response.data);

      if (response.statusCode == 200) {
        final LoginPerfil loginPerfil = LoginPerfil.fromJson(response.data);

        if (saveSession) {
          print(loginPerfil.token);
          print(email);
          print(password);
          SecureStorage().writeSecureData('token', loginPerfil.token);
          SecureStorage().writeSecureData('username', email);
          SecureStorage().writeSecureData('password', password);
        }
        Message.dissmiss(context);
        loginperfil.loginPerfil = loginPerfil;
        return loginPerfil;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        print(e.response?.data);
        Message.dissmiss(context);
        Errores().showErrorMessage(e, context);

        return null;
      }
    }
  }

  Future<String?> updateToken(String email, String password) async {
    try {
      final response = await _dio.request('login',
          data: {"username": email, "password": password},
          options: Options(method: 'POST'));
      final loginPerfil = jsonDecode(response.data);

      SecureStorage().writeSecureData('token', loginPerfil['token']);
      return loginPerfil['token'];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
