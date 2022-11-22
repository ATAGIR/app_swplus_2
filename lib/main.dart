import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/pages/auth_screen.dart';
import 'package:telemetria/pages/catalogo.dart';
import 'package:telemetria/pages/rfc_page.dart';
import 'package:telemetria/pages/the_catalogo.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'pages/login.dart';

main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      initialRoute: AuthScreen.routeName,
      routes: {
        Login.routeName: ((context) => const Login()),
        Catalogo.routeName: ((context) => const Catalogo()),
        TheCatalogo.routeName: ((context) => const TheCatalogo()),
        RfcPage.routeName: ((context) => const RfcPage()),
      },
    );
  }
}
