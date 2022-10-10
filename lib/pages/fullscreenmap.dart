import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class PageFullMap extends StatefulWidget {
  const PageFullMap({super.key});

  @override
  State<PageFullMap> createState() => _PageFullMapState();
}

class _PageFullMapState extends State<PageFullMap> {
  late MapboxMapController mapController;

  final cordenada = const LatLng(19.371192, -99.154645);
  String selectStyle = 'mapbox://styles/israel1993/cl8lwt9tc003b14mb1noleuvp';
  final streetStyle = 'mapbox://styles/israel1993/cl8lwkuk9001614nxwr7o4xl9';
  final minimalStyle = 'mapbox://styles/israel1993/cl8lwt9tc003b14mb1noleuvp';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  //Botones Flotantes ----------------------------------------------------------
  Column botonesFlotantes() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      //ZoomIn
      FloatingActionButton(
          heroTag: 'btn1',
          onPressed: (() {
            mapController.animateCamera(CameraUpdate.zoomIn());
          }),
          child: const Icon(Icons.zoom_in)),
      const SizedBox(height: 5),
      //ZoomOut
      FloatingActionButton(
          heroTag: "btn2",
          onPressed: (() {
            mapController.animateCamera(CameraUpdate.zoomOut());
          }),
          child: const Icon(Icons.zoom_out)),
      const SizedBox(height: 5),
      //Cambiar Estilo
      FloatingActionButton(
          heroTag: "btn3",
          child: const Icon(Icons.map),
          onPressed: () {
            if (selectStyle == minimalStyle) {
              selectStyle = streetStyle;
            } else {
              selectStyle = minimalStyle;
            }

            setState(() {});
          }),
    ]);
  }

  //Crear Mapa -----------------------------------------------------------------
  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: cordenada,
        zoom: 14,
      ),
    );
  }
}
