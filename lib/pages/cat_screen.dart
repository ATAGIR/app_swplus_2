import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/catalogo.dart';
import 'package:telemetria/providers/catalogo_prov.dart';

class CatScreen extends StatelessWidget {
  static const routeName = 'CatScreen';
  const CatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalogoProvider =
        Provider.of<CatalogoProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: catalogoProvider.leerToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('assets/imagenes/logo.jpeg'),
              );
            }
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
                          const Catalogo(),
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
                          const Catalogo(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  ),
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
