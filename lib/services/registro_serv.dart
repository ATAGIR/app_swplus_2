import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/api/configure_api.dart';
import 'package:telemetria/pages/registro_login.dart';
import 'package:telemetria/utils/message.dart';
import '../models/registroLog.dart';
import '../providers/registro_provider.dart';

class RegistroServ {
  static final RegistroServ _registroServ = RegistroServ._internal();


  factory RegistroServ() {
    return _registroServ;
  }
  RegistroServ._internal();
  final Dio _dio = Dio(ConfigureApi.options);

  Future<RegistroLog?> registro(BuildContext context, String username,
      String email, String password, int roleId) async {
    final registroLog = Provider.of<RegistroProvider>(context, listen: false);

    try {
      Message.show(context);
      final response = await _dio.request('register',
          data: {
            "username": username,
            "password": password,
            "email": email,
            "role_id": roleId
          },
          options: Options(method: 'POST'));

      print(response.data);

      if (response.statusCode == 200) {
        final RegistroLog registroLog = RegistroLog.fromJson(response.data);
        Message.dissmiss(context);
      } else {
        Message.dissmiss(context);
        return null;

      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        print(e.response?.data);
        Message.dissmiss(context);

        return null;
      }
    }
  }
}
