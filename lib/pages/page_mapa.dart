import 'package:flutter/material.dart';
import '../widget/ubicacion.dart';

class PageMapa extends StatelessWidget {
  static const routeName = 'PageMapa';
  const PageMapa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child:  const Ubicacion(minZoom: 5, maxZoom: 20, latitud: 20.56439, longitud: -100.3075),
      ),
    );
  }
}
