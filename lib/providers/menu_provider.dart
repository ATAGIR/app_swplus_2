// ignore_for_file: avoid_print

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];
  _MenuProvider();

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/sw_plus_info.json');
    Map dataMap = json.decode(resp);
    opciones = dataMap['rutas'];
    return opciones;
  }
}

final menuProvider = _MenuProvider();
