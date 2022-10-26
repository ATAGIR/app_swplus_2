import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/map_detail.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/ubicacion.dart';

Future<MapDetail>? _detalleMap;
List<MapDetail>? listaDetalleMap;
bool emptyArray = true;
String? itemSelected;

class PageMapa extends StatefulWidget {
  static const routeName = 'PageMapa';
  const PageMapa(this.latitud, this.longitud, this.nsut, this.etiqueta, {super.key});
  final double? latitud;
  final double? longitud;
  final String? nsut;
  final String? etiqueta;

  @override
  State<PageMapa> createState() => _PageMapaState();
}

class _PageMapaState extends State<PageMapa> {
  MapDetail? detalleActual;

  double? get longitud => null;
  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        // ignore: avoid_unnecessary_containers
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: responsive.hp(45),
                  child: Ubicacion(
                      minZoom: 5,
                      maxZoom: 20,
                      latitud: widget.latitud!,
                      longitud: widget.longitud!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
