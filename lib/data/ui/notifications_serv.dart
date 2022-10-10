import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationServ {
  static showSnackbar(
      BuildContext context, String message, Color color, double fontSize) {
    final snackbar = SnackBar(
        elevation: 20,
        backgroundColor: color,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static show(BuildContext context) {
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
