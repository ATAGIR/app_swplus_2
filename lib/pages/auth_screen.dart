import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/catalogo.dart';
import 'package:telemetria/pages/login.dart';
import 'package:telemetria/services/aut_serv.dart';
import 'package:telemetria/utils/secure_storage.dart';
import '../providers/login_prov.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = 'AuthScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    GlobalKey<FormState> frmKeyAuth = GlobalKey<FormState>();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    String? tokenCatalogo = '';

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: loginProvider.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                // ignore: sized_box_for_whitespace

                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset('assets/imagenes/logo.jpeg'),
                );
              } else {
                if (snapshot.data == '') {
                  Future.microtask(() => {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (
                                  _,
                                  __,
                                  ___,
                                ) =>
                                    const Login(),
                                //const ServicesScreen(),
                                transitionDuration: const Duration(seconds: 1)))
                        //Navigator.of(context).pushReplacementNamed(HomePage.routeName)
                      });
                } else {
                  
                  Future.microtask(() => {
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
                                    ),
                                transitionDuration: const Duration(seconds: 0)))
                      });
                }
              }
              return Container();
            }),
      ),
    );
  }
}
