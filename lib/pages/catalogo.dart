// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/listtile_telemetria.dart';
import 'package:telemetria/widget/searchtextform.dart';
import 'package:animate_do/animate_do.dart';
import '../providers/login_prov.dart';
import '../utils/secure_storage.dart';
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
List<MedidorUser>? listaMedidoresUser = [];

Future<List<Log>?>? detalleLog;
List<Log?>? listaDetalleLog;

bool emptyArray = true;
String? itemSeleccionado;
String? itemSeleccionado2;

const Map<String, int> itemOrdens = {
  "Conseción, A-Z": 1,
  "Conseción, Z-A": 2,
};

const Map<String, int> itemOrdens2 = {
  "Modelo, A-Z": 1,
  "Modelo, Z-A": 2,
};

class _CatalogoState extends State<Catalogo> {
  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _medidorUser =
        CatService().getLast(context, loginProvider.loginPerfil.token);
    listaDetalleLog = [];
    detalleLog = CatService().log(context, loginProvider.loginPerfil.token);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
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
                          height: responsive.hp(60),
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
                                            .where((element) => element
                                                .concesion!
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
                                      return ListTileTelemetria
                                          .listTileTELEMETRIA(
                                              buttonText: true,
                                              circleColor:
                                                  ColorTheme.indicatorColor,
                                              iconButton2:
                                                  Icons.arrow_forward_ios,
                                              onPressarrowButton: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Catalogo()));
                                              },
                                              nameMedidor:
                                                  listaMedidoresUser![index]
                                                      .rfc!,
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
                SizedBox(height: Responsive(context).wp(150)),
              ],
            ),
          ),
        ),
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
                          itemSeleccionado2 = value.trim();
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
                                                .contains(itemSeleccionado2!
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
                                              iconButton1: Icons.abc,
                                              iconButton2:
                                                  Icons.arrow_forward_ios,
                                              onPressarrowButton: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PageMapa()));
                                              },
                                              nameMedidor:
                                                  listaDetalleLog![index]!.rfc,
                                              subtitle:
                                                  '${listaDetalleLog?[index]!.modeloId}',
                                              // 'Folio ${listFileStatus![index].soNumero}  Fecha Alta ' + DateFormat('dd-MM-yyyy HH:mm:ss').format(listFileStatus![index].soFecAlta!),
                                              responsive: responsive);
                                    },
                                    itemCount: listaDetalleLog!.length,
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
                SizedBox(height: Responsive(context).wp(150)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
