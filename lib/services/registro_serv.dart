// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/api/configure_api.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/utils/message.dart';
import '../models/registroLog.dart';

class RegistroServ {
  static final RegistroServ _registroServ = RegistroServ._internal();

  factory RegistroServ() {
    return _registroServ;
  }
  RegistroServ._internal();
  final Dio _dio = Dio(ConfigureApi.options);

  Future<RegistroLog?> registroUsr(
    BuildContext context,
    String username,
    String email,
    String password,
    int roleId,
  ) async {
    final regUser = Provider.of<LoginProvider>(context, listen: false);
    try {
      Message.show(context);
      final response = await _dio.post('/auth/register',
          data: {
            "username": username,
            "password": password,
            "email": email,
            "role_Id": roleId,
          },
          options: Options(method: 'POST'));
      if (response.statusCode == 200) {
        Message.dissmiss(context);
        final RegistroLog registroLog = RegistroLog.fromJson(response.data);
        regUser.registroRegistration = registroLog;
        return registroLog;
      } else {
        Message.dissmiss(context);
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Message.dissmiss(context);
        return null;
      }
    }
    return null;
  }
}
