// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/page_registro.dart';
import 'package:telemetria/services/aut_serv.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/utils/caracteres.dart';
import 'package:telemetria/utils/message.dart';
import 'package:telemetria/utils/responsive.dart';
import 'catalogo.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.passwordVisible = false}) : super(key: key);
  static const routeName = 'login';
  static String id = 'login';
  final bool passwordVisible;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  bool passwordVisible = true;
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
                      'assets/imagenes/InfoPro.png',
                      height: responsive.hp(40),
                      width: responsive.wp(75),
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
          //initialValue: 'ielizalde@swplus.com.m',
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
         // initialValue: 'toke',
          keyboardType: TextInputType.emailAddress,
          obscureText: passwordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: const Icon(Icons.lock_rounded),
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
              fontSize: Responsive.of(context).dp(2), color: Colors.black54),
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
         if (email.isEmpty) {
          Message.showMessage(
              context: context,
              message: 'El correo no es valido',
              color: const Color(0xffBF4045));
          return;
        }
        if (password.isEmpty) {
          Message.showMessage(
              context: context,
              message: 'La contraseña debe de ser minimo 5 caracteres',
              color: const Color(0xffBF4045));
          return;
        }
        if (loginProvider.formKey.currentState!.validate()) {
          AutService()
              .emailLogin(context, email, password, _saveSession)
              .then((value) {
            print(value);
            if (value!.isActive == true) {
              String token = loginProvider.loginPerfil.token;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Catalogo(token:token)));
            } else {
              Message.msgNotActive;
            }
          });
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
                      builder: (context) => const PageRegistro()));
            },
          )
        ],
      );
}
