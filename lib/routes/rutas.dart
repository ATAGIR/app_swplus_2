import 'package:flutter/material.dart';

import '../pages/page_ajustes.dart';
import '../pages/page_productos.dart';
import '../pages/catalogo.dart';

class Rutas extends StatelessWidget {
  final int index;

  const Rutas({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> listaWidget = [
      const PageProducto(),
      const PageAjustes(),
      const Catalogo(),
    ];
    return listaWidget[index];
  }
}
