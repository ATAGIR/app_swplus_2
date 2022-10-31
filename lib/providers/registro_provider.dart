
import 'package:flutter/cupertino.dart';
import 'package:telemetria/models/registroLog.dart';

class RegistroProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _username = '';
  String get username => _username;
  set username(String username){
    _username = username;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String email){
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password){
    _password = password;
    notifyListeners();
  }

  RegistroLog? _registro;
  RegistroLog get registro => _registro!;
  set registro(RegistroLog registro) {
    _registro = registro;
    notifyListeners();
  }
}