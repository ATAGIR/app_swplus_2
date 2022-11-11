import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/catalogo.dart';
import 'package:telemetria/pages/login.dart';
import '../providers/login_prov.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = 'AuthScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loginProvider.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('assets/imagenes/logo.jpeg'),
              );
            } else {
              if (snapshot.data == '') {
                Future.microtask(
                  () => {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (
                          _,
                          __,
                          ___,
                        ) =>
                            const Login(),
                        transitionDuration: const Duration(seconds: 1),
                      ),
                    ),
                  },
                );
              } else {
                Future.microtask(
                  () => {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (
                          _,
                          __,
                          ___,
                        ) =>
                            Catalogo(
                          token: loginProvider.token,
                          username: loginProvider.loginPerfil.username,
                          role: loginProvider.loginPerfil.role,
                        ),
                        transitionDuration: const Duration(seconds: 1),
                      ),
                    ),
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
