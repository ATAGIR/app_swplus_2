import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/auth_screen.dart';
import 'package:telemetria/pages/cat_screen.dart';
import 'package:telemetria/pages/catalogo.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'pages/login.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AuthScreen.routeName,
      routes: {
        Login.routeName: (context) => const Login(),
        Catalogo.routeName: ((context) => const Catalogo()),
        AuthScreen.routeName: ((context) => const AuthScreen()),
        CatScreen.routeName: ((context) => const AuthScreen()),
      },
    );
  }
}
