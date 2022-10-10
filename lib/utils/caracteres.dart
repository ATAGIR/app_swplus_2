// ignore_for_file: non_constant_identifier_names

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
}
