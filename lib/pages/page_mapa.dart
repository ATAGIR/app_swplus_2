// ignore_for_file: unused_label, dead_code

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/map_detail.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
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
  var _currentSelectedDate = DateTime.now();
  var _currentTime = TimeOfDay.now();
  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    setState(
      () {
        _currentSelectedDate = selectedDate!;
      },
    );
  }

  void callTimePicker() async {
    var selectedTime = await getDatePickerWidget();
    setState(
      () {
        _currentTime = selectedTime as TimeOfDay;
      },
    );
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: _currentSelectedDate,
        firstDate: DateTime(2017),
        lastDate: DateTime(2023),
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    builder:
    (context, child) {
      return Theme(data: ThemeData.dark(), child: child);
    };
  }

  Future<TimeOfDay?> getTimePickerWidget() {
    return showTimePicker(
      context: context,
      initialTime: _currentTime,
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );
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
                SizedBox(height: responsive.hp(2)),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Center(
                        child: const Text('Selecciona una fecha para filtrar'),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: callDatePicker,
                            icon: const Icon(Icons.calendar_month_outlined),
                          ),
                          SizedBox(width: responsive.wp(5)),
                          Text('$_currentSelectedDate'),
                        ],
                      ),
                    ],
                  ),
                ),
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
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: SizedBox(
                                                        height:
                                                            responsive.hp(20),
                                                        width:
                                                            responsive.wp(95),
                                                        child: Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      responsive
                                                                          .hp(1),
                                                                ),
                                                                Table(
                                                                  columnWidths: {
                                                                    0: FixedColumnWidth(
                                                                      responsive
                                                                          .wp(3),
                                                                    ),
                                                                    1: FixedColumnWidth(
                                                                      responsive
                                                                          .wp(31),
                                                                    )
                                                                  },
                                                                  children: [
                                                                    //0
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'Fecha: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].fecha}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //1
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'Modelo: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].modelo}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //2
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'Sistema: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].sistema}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //3
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'RFC: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].rfc}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //4
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'NSM: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].nsm}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //5
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'Norma: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].nsue}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //6
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'IMEI: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].imei}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                    //7
                                                                    TableRow(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              responsive.wp(2),
                                                                        ),
                                                                        const Text(
                                                                          'CCID: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                            '${listaDetalleMap?[index].ccid}',
                                                                            style:
                                                                                const TextStyle(color: Colors.white)) //
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
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
                                                          'Fecha: ${listaDetalleMap![index].fecha!}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsive
                                                                      .dp(1.5)),
                                                        ),
                                                        const Spacer(),
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.location_on,
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
}
