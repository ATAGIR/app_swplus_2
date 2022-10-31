import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:telemetria/api/configure_api.dart';

class Ubicacion extends StatelessWidget {
  final double minZoom;
  final double maxZoom;
  final double latitud;
  final double longitud;

  const Ubicacion(
      {super.key,
      required this.minZoom,
      required this.maxZoom,
      required this.latitud,
      required this.longitud});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitud, longitud),
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: ConfigureApi.mapBoxUrl,
          additionalOptions: {
            'mapStyleId': ConfigureApi.mapBoxStyleId,
            'accessToken': ConfigureApi.mapBoxAccessToken,
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(latitud, longitud),
              builder: (context) =>
                  const Icon(Icons.pin_drop, color: Colors.redAccent),
            ),
          ],
        ),
      ],
    );
  }
}
