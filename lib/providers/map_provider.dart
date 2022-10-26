import 'package:flutter/cupertino.dart';
import '../utils/secure_storage.dart';

class MapProvider extends ChangeNotifier {
  String _token = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String get token => _token;
  set token(String valuetoken){
    _token = valuetoken;
  }

  String _nsut = '';
  String get nsut => _nsut;
  set nsut(String nsut) {
    _nsut = nsut;
    notifyListeners();
  }

  String _etiqueta = '';
  String get etiqueta => _etiqueta;
  set etiqueta(String etiqueta){
    _etiqueta = etiqueta;
    notifyListeners();
  }

  int _dias = 0;
  int get dias => _dias;
  set dias(int dias){
    _dias = dias;
    notifyListeners();
  }

  Future<String>readToken() async{
    var token = await SecureStorage().readSecureData('token');
    if (token == null) {
      return '';
    } else {
      return token;
    }
  }

}