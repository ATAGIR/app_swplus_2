import 'package:flutter/material.dart';
import 'package:telemetria/routes/rutas.dart';

import 'boton_nav.dart';

class VerLista extends StatelessWidget {
  const VerLista({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BotonNav? myBNB;
  @override
  void initState() {
    myBNB = BotonNav(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBNB,
      body: Center(
        child: Rutas(index: index),
      ),
    );
  }
}
