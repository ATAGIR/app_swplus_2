// ignore_for_file: non_constant_identifier_names

import 'message.dart';

class Caracteres {
  static final Caracteres _Caracteres = Caracteres._internal();
  factory Caracteres() {
    return _Caracteres;
  }

  Caracteres._internal();

  String? validaCorreo(String correo) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(correo) ? null : 'No es un correo valido';
  }
  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$*~]).{8,}$');
    if (value.isEmpty) {
      return Message.validatePasswordregex;
    } else {
      if (!regex.hasMatch(value)) {
        return Message.validatePassword;
      } else {
        return null;
      }
    }
  }
}