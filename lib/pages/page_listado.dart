
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/providers/menu_provider.dart';

class PageListado extends StatelessWidget {
  final ShapeBorder? shape;
  const PageListado({super.key, this.shape});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: const [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data ?? []),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> opciones = [];
    for (var opt in data) {
//Inicio de el Slidable
      final widgetTemp = Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                //Delete
              },
              icon: Icons.delete,
              label: 'Borrar',
              backgroundColor: Colors.redAccent,
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PageMapa()));
              },
              icon: Icons.info_outline_rounded,
              foregroundColor: Colors.red,
              label: 'Info',
              backgroundColor: Colors.yellow,
            ),
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.archive,
              label: 'Archivar',
              backgroundColor: Colors.green,
            )
          ],
        ),
// Inicio Contenedor
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade300,
            ),
            //padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: const Icon(Icons.arrow_left_rounded),
              trailing: const Icon(Icons.arrow_right_rounded),
              title: Text(opt['etiqueta']),
              onTap: () {},
            ),
          ),
        ),
      );

      opciones
        ..add(widgetTemp)
        ..add(const Divider(
          color: Colors.white,
        ));
    }
    return opciones;
  }
}
