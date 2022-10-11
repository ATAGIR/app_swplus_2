// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:telemetria/utils/secure_storage.dart';

class CatalogoProvider extends ChangeNotifier {
  String _token = '';

  GlobalKey<FormState> toKey = GlobalKey<FormState>();
  String get token => _token;
  set token(String valueToken) {
    _token = valueToken;
  }

  Future<String> leerToken() async {
    var token = await SecureStorage().readSecureData('token');
    if (token == null) {
      return '';
    }else{
      return token;
    }
  }
}
