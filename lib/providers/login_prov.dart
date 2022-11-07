// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_print, unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/models/registroLog.dart';
import '../services/aut_serv.dart';
import '../utils/secure_storage.dart';

class LoginProvider extends ChangeNotifier {
  bool _saveSession = false;

  String _token = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get token => _token;
  set token(String valuetoken) {
    _token = valuetoken;
  }

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  bool get saveSession => _saveSession;
  set saveSession(bool token) {
    _saveSession = token;
    notifyListeners();
  }

  String _username = '';
  String get username => _username;
  set username(String username) {
    _username = username;
    notifyListeners();
  }

  String _emailRegistration = '';
  String get emailRegistration => _emailRegistration;
  set emailRegistration(String emailRegistration) {
    _emailRegistration = emailRegistration;
    notifyListeners();
  }

  String _passwordRegistration = '';
  String get passwordRegistration => _passwordRegistration;
  set passwordRegistration(String passwordRegistration) {
    _passwordRegistration = passwordRegistration;
    notifyListeners();
  }

  Future<String> readToken() async {
    var token = await SecureStorage().readSecureData('token');
    print(token);
    if (token == null) {
      return '';
    } else {
      return token;
    }
  }

  RegistroLog? _registroRegistration;
  RegistroLog get registroRegistration => _registroRegistration!;
  set registroRegistration(RegistroLog registroRegistration) {
    _registroRegistration = registroRegistration;
    notifyListeners();
  }

  LoginPerfil? _loginPerfil;
  LoginPerfil get loginPerfil => _loginPerfil!;
  set loginPerfil(LoginPerfil loginPerfil) {
    _loginPerfil = loginPerfil;
    notifyListeners();
  }

  LoginProvider() {
    obtenerToken();
    print(saveSession);
  }

  obtenerToken() async {
    var _token, _email, _password;

    _token = await SecureStorage().readSecureData('token') ?? '';
    _email = await SecureStorage().readSecureData('username') ?? '';
    _password = await SecureStorage().readSecureData('password') ?? '';

    if (_token == '') {
      saveSession = false;
    } else {
      saveSession = true;
      email = _email;
      password = _password;
      token = _token;

      AutService().updateToken(email, password).then((value) {
        token = value!;
        notifyListeners();
        print(token);
      });
    }
  }
}
