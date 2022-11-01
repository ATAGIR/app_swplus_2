import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/notifications_serv.dart';

class Message {
  static final Message _message = Message._internal();
  factory Message() {
    return _message;
  }
  Message._internal();
  static String msgNotActive = 'Usuario no activo';
  static String validatePasswordregex = ' Ingrese su contraseña';
  static String validatePassword =
      ' Ingrese su contraseña';

  static showMessage(
      {required BuildContext context,
      required String message,
      required Color color,
      double fontSize = 15}) async {
    await NotificationServ.showSnackbar(context, message, color, fontSize);
  }

  static show(context) {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
            onWillPop: () async => false,
          );
        });
  }

  static dissmiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
