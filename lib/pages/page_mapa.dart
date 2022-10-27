// ignore_for_file: unused_label

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/map_detail.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';

import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/listtile_telemetria.dart';
import 'package:telemetria/widget/ubicacion.dart';

Future<List<MapDetail>?>? _detalleMap;
List<MapDetail>? listaDetalleMap;
bool emptyArray = true;
String? itemSelected;

class PageMapa extends StatefulWidget {
  static const routeName = 'PageMapa';
  const PageMapa(
      {this.latitud, this.longitud, this.nsut, this.etiqueta, super.key});
  final double? latitud;
  final double? longitud;
  final String? nsut;
  final String? etiqueta;

  @override
  State<PageMapa> createState() => _PageMapaState();
}

class _PageMapaState extends State<PageMapa> {
  var _currentSelectedDate;

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      _currentSelectedDate = selectedDate;
    });
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2017),
        lastDate: DateTime(2023));
    // ignore: dead_code
    builder:
    (context, child) {
      return Theme(data: ThemeData.light(), child: child);
    };
  }

  double? get longitud => null;
  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _detalleMap = CatService().getMapDetail(context,
        loginProvider.loginPerfil.token, widget.nsut, widget.etiqueta, 999);
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
                  SizedBox(height: Responsive(context).hp(2)),
                  ElevatedButton(
                    onPressed: callDatePicker,
                    child: const Text('Aceptar'),
                  ),
                  Text('Fecha Seleccionada $_currentSelectedDate'),
                  _detalleMap != null
                      ? SingleChildScrollView(
                          child: SizedBox(
                            height: responsive.hp(50),
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
                                              .where((element) => element
                                                  .modelo!
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
                                        return ListTileTelemetria
                                            .listTileTELEMETRIA(
                                                buttonText: true,
                                                circleColor:
                                                    ColorTheme.indicatorColor,
                                                iconButton2:
                                                    Icons.arrow_forward_ios,
                                                onPressarrowButton: () {},
                                                nameMedidor:
                                                    listaDetalleMap![index]
                                                        .modelo!,
                                                subtitle:
                                                    'Fecha:  ${listaDetalleMap?[index].fecha}',
                                                responsive: responsive,
                                                iconButton1: Icons.abc,
                                                textButton: 'Ver');
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
            )),
      ),
    );
  }
}
