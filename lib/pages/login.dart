// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/registro_login.dart';
import 'package:telemetria/services/aut_serv.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/utils/caracteres.dart';
import 'package:telemetria/utils/message.dart';
import 'package:telemetria/utils/responsive.dart';
import 'catalogo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = 'login';
  static String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  bool _saveSession = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);

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
            child: Center(
              child: Form(
                key: loginProvider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imagenes/logo.png',
                      height: responsive.hp(45),
                      width: responsive.wp(80),
                    ),
                    _userTextField(),
                    SizedBox(height: Responsive(context).wp(7)),
                    _passwordTextField(),
                    SizedBox(height: Responsive(context).wp(2)),
                    _bottonRecordarme(context, loginProvider),
                    SizedBox(height: Responsive(context).wp(2)),
                    _bottonLogin(context, loginProvider),
                    SizedBox(height: Responsive(context).wp(2)),
                    _bottonRegistrarse(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
          initialValue: 'psi@swplus.com.m',
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: Icon(Icons.email),
            hintText: 'Correo electronico',
            labelText: 'Correo electronico',
          ),
          onChanged: (value) => email = value.trim(),
          validator: (value) {
            return Caracteres().validaCorreo(value!);
          },
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
          initialValue: 'toke',
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: Icon(Icons.lock_rounded),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (value) => password = value.trim(),
          validator: (value) {
            if (value != null && value.length >= 5) {
              return null;
            } else {
              return 'Verifique su contraseña';
            }
          },
        ),
      );
    });
  }

  Widget _bottonRecordarme(BuildContext context, LoginProvider loginProvider) {
    loginProvider.saveSession == false;
    return SwitchListTile.adaptive(
        title: Text(
          'Recordarme',
          style: TextStyle(
              fontSize: Responsive.of(context).dp(2), color: Colors.black),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: Responsive(context).wp(10)),
        value: _saveSession,
        onChanged: (bool? value) {
          setState(() {
            _saveSession = value!;
          });
          print(value);
        });
  }

  Widget _bottonLogin(BuildContext context, LoginProvider loginProvider) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (loginProvider.formKey.currentState!.validate()) {
          AutService()
              .emailLogin(context, email, password, _saveSession)
              .then((value) {
            print(value);
            if (value!.isActive == true) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Catalogo.routeName, (route) => false);
            } else {
              Message.msgNotActive;
            }
          });
        } else {
          print('Mensage toast , llene los campos solicitados');
        }
      },
      child: SizedBox(
          width: Responsive(context).wp(30),
          height: Responsive(context).hp(7),
          child: const Center(child: Text('Iniciar'))),
    );
  }

  Widget _bottonRegistrarse() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('¿Aun no tienes cuenta?'),
          TextButton(
            child: const Text("Registrarse"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistroLogin()));
            },
          )
        ],
      );
}
