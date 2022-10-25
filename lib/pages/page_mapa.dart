import 'package:flutter/material.dart';
import 'package:telemetria/utils/responsive.dart';
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
    final responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        // ignore: avoid_unnecessary_containers
        body: Container(
          height: responsive.hp(45),
          child: Ubicacion(
              minZoom: 5,
              maxZoom: 20,
              latitud: widget.latitud!,
              longitud: widget.longitud!),
        ),
      ),
    );
  }
}
