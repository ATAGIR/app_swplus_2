// ignore_for_file: unused_label, dead_code, unused_local_variable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/map_detail.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/image_background.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/ubicacion.dart';

Future<List<MapDetail>?>? _detalleMap;
List<MapDetail>? listaDetalleMap;
bool emptyArray = true;
String? itemSelected;

const Map<String, int> opcionOrden = {
  "Utimo día": 1,
  "Ultima semana": 7,
  "Ultimos 30 dias": 30,
};

const Map<int, String> rangoDias = {
  1: "Utimo día",
  7: "Ultima semana",
  30: "Ultimos 30 dias"
};

class PageMapa extends StatefulWidget {
  static const routeName = 'PageMapa';
  const PageMapa(
      {required this.latitud,
      required this.longitud,
      required this.nsut,
      required this.etiqueta,
      required this.token,
      super.key});
  final double latitud;
  final double longitud;
  final String nsut;
  final String etiqueta;
  final String token;
  @override
  State<PageMapa> createState() => _PageMapaState();
}

class _PageMapaState extends State<PageMapa> {
  int? ordens;
  double? get longitud => null;

  @override
  void initState() {
    super.initState();

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    _detalleMap = CatService()
        .getMapDetail(context, widget.token, widget.nsut, widget.etiqueta, 1);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    var index = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Column(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.etiqueta,
              style:
                  TextStyle(color: Colors.black, fontSize: responsive.dp(1.5)),
            ),
            Text(
              widget.nsut,
              style:
                  TextStyle(color: Colors.black, fontSize: responsive.dp(1.5)),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: ImageBackground.imagebackground(opacity: 0.1),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: responsive.dp(16.3),
                  child: Ubicacion(
                      minZoom: 5,
                      maxZoom: 20,
                      latitud: widget.latitud,
                      longitud: widget.longitud),
                ),
                SizedBox(height: responsive.hp(2)),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LabelText(
                            txtValor: 'Seleccione un rango',
                            fontSize: responsive.dp(1.8),
                            colorText: Colors.black54,
                          ),
                          DropdownButton<int>(
                            hint: Text(
                              'Seleccionar',
                              style: TextStyle(color: ColorTheme.thetextColor),
                            ),
                            style: TextStyle(color: ColorTheme.thetextColor),
                            items: opcionOrden
                                .map(
                                  (descripcion, value) {
                                    return MapEntry(
                                      descripcion,
                                      DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(descripcion),
                                      ),
                                    );
                                  },
                                )
                                .values
                                .toList(),
                            value: ordens,
                            onChanged: (int? value) {
                              ordens = value!;
                              setState(() {
                                print(ordens);

                                final loginProvider =
                                    Provider.of<LoginProvider>(context,
                                        listen: false);

                                _detalleMap = CatService().getMapDetail(
                                    context,
                                    widget.token,
                                    widget.nsut,
                                    widget.etiqueta,
                                    ordens!);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _detalleMap != null
                    ? SingleChildScrollView(
                        child: SizedBox(
                          height: responsive.hp(54),
                          width: responsive.wp(97),
                          child: FutureBuilder<List<MapDetail>?>(
                            future: _detalleMap,
                            builder: (context,
                                AsyncSnapshot<List<MapDetail>?> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                emptyArray
                                    ? {
                                        listaDetalleMap = snapshot.data,
                                      }
                                    : {
                                        listaDetalleMap = listaDetalleMap!
                                            .where((element) => element.modelo!
                                                .toLowerCase()
                                                .contains(itemSelected!
                                                    .toLowerCase()))
                                            .toList(),
                                      };
                                return SlideInLeft(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      DateTime? now =
                                          listaDetalleMap?[index].fecha;
                                      String formattedDate =
                                          DateFormat(' dd-MM-yyyy – kk:mm')
                                              .format(now!);
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              verDialogo(
                                                  context, responsive, index);
                                            },
                                            child: Card(
                                              elevation: 5,
                                              color: Colors.grey.shade100,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    //leading: const Icon(Icons.abc),
                                                    title: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Fecha: $formattedDate',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        const Spacer(),
                                                        IconButton(
                                                          onPressed: () {
                                                            verDialogo(
                                                                context,
                                                                responsive,
                                                                index);
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Row(
                                                      children: [
                                                        Text(
                                                          'Gasto: ${listaDetalleMap![index].gasto!}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsive
                                                                      .dp(1.2)),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          'Volumen: ${listaDetalleMap![index].vol!}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsive
                                                                      .dp(1.2)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: listaDetalleMap!.length,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'Sin Archivos',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: ColorTheme.fontFamily,
                              fontSize: 14),
                        ),
                      ),
                SizedBox(height: Responsive(context).wp(0.1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> verDialogo(
      BuildContext context, Responsive responsive, int index) {
    return showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) {
        DateTime? now = listaDetalleMap?[index].fecha;
        String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now!);
        return Center(
          child: SizedBox(
           
            height: responsive.hp(25),
            width: responsive.wp(92),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    Table(
                      columnWidths: {
                        0: FixedColumnWidth(
                          responsive.wp(3),
                        ),
                        1: FixedColumnWidth(
                          responsive.wp(31),
                        )
                      },
                      children: [
                        //0
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'Fecha:',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(color: Colors.white),
                            ) //
                          ],
                        ),
                        //1
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'Modelo: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].modelo}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //2
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'Sistema: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].sistema}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //3
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'RFC: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].rfc}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //4
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'NSM: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].nsm}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //5
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'Norma: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].nsue}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //6
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'IMEI: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].imei}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                        //7
                        TableRow(
                          children: [
                            SizedBox(
                              width: responsive.wp(2),
                            ),
                            const Text(
                              'CCID: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('${listaDetalleMap?[index].ccid}',
                                style: const TextStyle(color: Colors.white)) //
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
