// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:telemetria/widget/form_registro.dart';
import '../utils/responsive.dart';

class PageRegistro extends StatefulWidget {
  static const routeName = 'RegistroLogin';
  const PageRegistro({Key? key}) : super(key: key);
  static String id = 'Registrarse';

  @override
  State<PageRegistro> createState() => _PageRegistroState();
}

class _PageRegistroState extends State<PageRegistro> {
  // _submit() {
  //   final isOk = _formKey.currentState.validate();
  //   print("for isOk $isOk");
  // }

  @override
  void initState() {
    super.initState();
  }
  String username = '';
  String email = '';
  String password = '';
  String confirmarPassword = '';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.heigth,
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            child: Stack(children: [
              FormRegistro(),
            ]),
          ),
        ),
      )),
    );
  }
}
