// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/utils/secure_storage.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/listtile_telemetria.dart';
import 'package:telemetria/widget/searchtextform.dart';
import 'package:animate_do/animate_do.dart';
import 'login.dart';
import 'package:intl/intl.dart';

class Catalogo extends StatefulWidget {
  static const routeName = 'Catalogo';

  const Catalogo({super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

int? ordens;
Future<List<MedidorUser>?>? _medidorUser;
List<MedidorUser>? listaMedidoresUser;

Future<List<Log>?>? detalleLog;
List<Log?>? listaDetalleLog;

bool emptyArray = true;
String? itemSeleccionado;

const Map<String, int> itemOrdens = {
  "Conseción, A-Z": 1,
  "Conseción, Z-A": 2,
};

const Map<String, int> itemOrdens2 = {
  "Modelo, A-Z": 1,
  "Modelo, Z-A": 2,
};

class _CatalogoState extends State<Catalogo> {
  MedidorUser? logActual;
  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    _medidorUser =
        CatService().getLast(context, loginProvider.loginPerfil.token);
    listaDetalleLog = [];
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      drawer: drawer(responsive, context),
      onDrawerChanged: (isOpen) {
        if (!isOpen) {
          setState(() {});
        }
      },
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              SecureStorage().deleteSecureData('token');
              SecureStorage().deleteSecureData('username');
              SecureStorage().deleteSecureData('password');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        //diseño pagina
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: responsive.hp(2),
              ),
              SearchTextForm(
                width: responsive.wp(60),
                height: responsive.hp(5),
                borderColor: ColorTheme.iconsColor,
                backgroundColor: ColorTheme.thetextBackgroundColor,
                labelText: 'Buscar',
                onPressed: () {},
                iconSize: responsive.dp(2.1),
                onChanged: (value) {
                  setState(
                    () {
                      if (value.isEmpty) {
                        emptyArray = true;
                      } else {
                        emptyArray = false;
                        itemSeleccionado = value.trim();
                      }
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LabelText(
                    txtValor: 'Modelo',
                    fontSize: responsive.dp(1.8),
                    colorText: Colors.black54,
                  ),
                  DropdownButton<int>(
                    hint: Text(
                      'Ordenar por',
                      style: TextStyle(color: ColorTheme.thetextColor),
                    ),
                    style: TextStyle(color: ColorTheme.thetextColor),
                    items: itemOrdens2
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
                      switch (ordens) {
                        case 1:
                          setState(
                            () {
                              listaDetalleLog!.sort(
                                (a, b) => a!.modelo!.compareTo(b!.modelo!),
                              );
                            },
                          );
                          break;
                        case 2:
                          setState(
                            () {
                              listaDetalleLog!.sort(
                                (a, b) => b!.modelo!.compareTo(a!.modelo!),
                              );
                            },
                          );
                          break;
                        default:
                      }
                    },
                  ),
                ],
              ),
              //Text('Total Logs : ${logActual?.logs?.length ?? 0}'),
              SlideInLeft(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
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
                                              color: Colors.blue, width: 1.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          height: responsive.hp(25),
                                          width: responsive.wp(95),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: responsive.hp(1),
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
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'Etiqueta: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].etiqueta}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'NSUT: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].nsut}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'Fecha ultimo Registro: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].fecha}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'Modelo: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].modelo}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'NSM: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].nsm}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          SizedBox(
                                                            width: responsive
                                                                .wp(2),
                                                          ),
                                                          const Text(
                                                            'NSUE: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              '${logActual!.logs![index].nsue}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)) //
                                                        ],
                                                      )
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
                                            'NSUT: ${logActual!.logs![index].nsut}',
                                            style: TextStyle(
                                                fontSize: responsive.dp(1.5)),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              double? latitud =
                                                  logActual!.logs![index].lat;
                                              double? longitud =
                                                  logActual!.logs![index].long;
                                              String? nsut =
                                                  logActual!.logs![index].nsut;
                                              String? etiqueta = logActual!
                                                  .logs![index].etiqueta;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageMapa(
                                                          latitud: latitud,
                                                          longitud: longitud,
                                                          nsut: nsut,
                                                          etiqueta: etiqueta),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.location_on,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),

                                      subtitle: Row(
                                        children: [
                                          Text(
                                            'Modelo: ${logActual!.logs![index].modelo}',
                                            style: TextStyle(
                                                fontSize: responsive.dp(1.2)),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Etiqueta: ${logActual!.logs![index].etiqueta}',
                                            style: TextStyle(
                                                fontSize: responsive.dp(1.2)),
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
                      itemCount: logActual?.logs?.length ?? 0,
                    ),
                  ],
                ),
              ),
              detalleLog != null
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: responsive.hp(60),
                        width: responsive.wp(97),
                        child: FutureBuilder<List<Log>?>(
                          future: detalleLog,
                          builder:
                              (context, AsyncSnapshot<List<Log>?> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              emptyArray
                                  ? {
                                      listaDetalleLog = snapshot.data,
                                    }
                                  : {
                                      listaDetalleLog = listaDetalleLog!
                                          .where((element) => element!.modelo!
                                              .toLowerCase()
                                              .contains(itemSeleccionado!
                                                  .toLowerCase()))
                                          .toList(),
                                    };
                              return SlideInLeft(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Text(
                                        '${logActual!.logs![index].modelo}');
                                  },
                                  itemCount: logActual?.logs?.length ?? 0,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        '',
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
    );
  }

  Drawer drawer(Responsive responsive, BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: responsive.wp(100), //500.0,
              height: responsive.hp(30),
              color: Colors.white60,
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              child: Container(
                color: Colors.white60,
                child: Container(
                  width: responsive.wp(50),
                  height: responsive.wp(50),
                  decoration: BoxDecoration(
                    color: const Color(0xffecf0f3),
                    borderRadius: BorderRadius.circular(150),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        (Colors.white60),
                        Color(0xffced2d5),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        offset: const Offset(-16.3, -16.3),
                        blurRadius: responsive.dp(2),
                        spreadRadius: 0.0,
                      ),
                      BoxShadow(
                        color: const Color(0xffced2d5),
                        offset: const Offset(16.3, 16.3),
                        blurRadius: responsive.dp(2),
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/imagenes/logo_sw.png",
                    height: responsive.hp(5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: responsive.hp(2),
            ),
            SearchTextForm(
              width: responsive.wp(60),
              height: responsive.hp(5),
              borderColor: ColorTheme.iconsColor,
              backgroundColor: ColorTheme.thetextBackgroundColor,
              labelText: 'Buscar',
              onPressed: () {},
              iconSize: responsive.dp(2.1),
              onChanged: (value) {
                setState(
                  () {
                    if (value.isEmpty) {
                      emptyArray = true;
                    } else {
                      emptyArray = false;
                      itemSeleccionado = value.trim();
                    }
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LabelText(
                  txtValor: 'Conseción',
                  fontSize: responsive.dp(1.8),
                  colorText: Colors.black54,
                ),
                DropdownButton<int>(
                  hint: Text(
                    'Ordenar por',
                    style: TextStyle(color: ColorTheme.thetextColor),
                  ),
                  style: TextStyle(color: ColorTheme.thetextColor),
                  items: itemOrdens
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
                    switch (ordens) {
                      case 1:
                        setState(
                          () {
                            listaMedidoresUser!.sort(
                              (a, b) => a.rfc!.compareTo(b.rfc!),
                            );
                          },
                        );
                        break;
                      case 2:
                        setState(
                          () {
                            listaMedidoresUser!.sort(
                              (a, b) => b.rfc!.compareTo(a.rfc!),
                            );
                          },
                        );
                        break;
                      default:
                    }
                  },
                ),
              ],
            ),
            _medidorUser != null
                ? SingleChildScrollView(
                    child: SizedBox(
                      height: responsive.hp(50),
                      width: responsive.wp(97),
                      child: FutureBuilder<List<MedidorUser>?>(
                        future: _medidorUser,
                        builder: (context,
                            AsyncSnapshot<List<MedidorUser>?> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            emptyArray
                                ? {
                                    listaMedidoresUser = snapshot.data,
                                  }
                                : {
                                    listaMedidoresUser = listaMedidoresUser!
                                        .where((element) => element.concesion!
                                            .toLowerCase()
                                            .contains(itemSeleccionado!
                                                .toLowerCase()))
                                        .toList(),
                                  };
                            return SlideInLeft(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTileTelemetria.listTileTELEMETRIA(
                                      buttonText: true,
                                      circleColor: ColorTheme.indicatorColor,
                                      iconButton2: Icons.arrow_forward_ios,
                                      onPressarrowButton: () {
                                        logActual = listaMedidoresUser![index];
                                        Navigator.pop(context);
                                      },
                                      nameMedidor:
                                          listaMedidoresUser![index].rfc!,
                                      subtitle:
                                          'Razon Social:  ${listaMedidoresUser?[index].razonSocial}',
                                      responsive: responsive,
                                      iconButton1: Icons.abc,
                                      textButton: 'Ver');
                                },
                                itemCount: listaMedidoresUser!.length,
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
    );
  }
}
