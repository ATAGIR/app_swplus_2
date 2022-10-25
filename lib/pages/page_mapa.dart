import 'package:flutter/material.dart';
import '../widget/ubicacion.dart';

class PageMapa extends StatefulWidget {
  static const routeName = 'PageMapa';
  const PageMapa(this.latitud, this.longitud, {super.key});

  final double? latitud;
  final double? longitud;

  @override
  State<PageMapa> createState() => _PageMapaState();
}

class _PageMapaState extends State<PageMapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Ubicacion(
            minZoom: 5,
            maxZoom: 20,
            latitud: widget.latitud!,
            longitud: widget.longitud!),
      ),
    );
  }
}
