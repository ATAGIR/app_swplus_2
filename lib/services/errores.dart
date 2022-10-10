// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/message.dart';

class Errores {
  static final Errores _errores = Errores._internal();
  factory Errores() {
    return _errores;
  }
  Errores._internal();

  showErrorMessage(DioError e, BuildContext context) async {
    Object? error;
    if (e.response?.data == null) {
      error = '9999';
    } else {
      error = e.response!.statusCode;
    }

    if (isNumeric(error.toString())) {
      switch (int.parse(error.toString())) {
        case 401:
          await Message.showMessage(
              context: context,
              message: 'No autorizado\nIngrese Nuevamente',
              color: Colors.red,
              fontSize: 20);
          break;

        case 404:
          await Message.showMessage(
              context: context,
              message: 'Error en el método llamado',
              color: Colors.red,
              fontSize: 20);
          break;
        case 9999:
          await Message.showMessage(
              context: context,
              message: 'Las credenciales no son validas\nRevise su información',
              color: Colors.red,
              fontSize: 20);
          break;
      }
    }
  }

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
