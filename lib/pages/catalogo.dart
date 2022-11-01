import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/pages/auth_screen.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/message.dart';
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
              Navigator.pushNamedAndRemoveUntil(
                  context, AuthScreen.routeName, (route) => false);
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
                                      child: SizedBox(
                                        height: responsive.hp(25),
                                        width: responsive.wp(95),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: responsive.hp(2),
                                                ),
                                                Table(
                                                  border: const TableBorder(
                                                    verticalInside: BorderSide(
                                                        width: 1.2,
                                                        color: Colors.blue,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'Etiqueta: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].etiqueta}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'NSUT: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].nsut}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'Fecha de último Registro: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].fecha}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'Modelo: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].modelo}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'NSM: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].nsm}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        const Text(
                                                          'NSUE: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '  ${logActual!.logs![index].nsue}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ) //
                                                      ],
                                                    )
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
                                              fontSize: responsive.dp(1.2),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Etiqueta: ${logActual!.logs![index].etiqueta}',
                                            style: TextStyle(
                                              fontSize: responsive.dp(1.2),
                                            ),
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
              // detalleLog != null
              //     ? SingleChildScrollView(
              //         child: SizedBox(
              //           height: responsive.hp(60),
              //           width: responsive.wp(97),
              //           child: FutureBuilder<List<Log>?>(
              //             future: detalleLog,
              //             builder:
              //                 (context, AsyncSnapshot<List<Log>?> snapshot) {
              //               if (!snapshot.hasData) {
              //                 return const Center(
              //                   child: CircularProgressIndicator(),
              //                 );
              //               } else {
              //                 emptyArray
              //                     ? {
              //                         //asd
              //                         listaDetalleLog = snapshot.data,
              //                       }
              //                     : {
              //                         listaDetalleLog = listaDetalleLog!
              //                             .where((element) => element!.modelo!
              //                                 .toLowerCase()
              //                                 .contains(itemSeleccionado2!
              //                                     .toLowerCase()))
              //                             .toList(),
              //                       };
              //                 return SlideInLeft(
              //                   child: ListView.builder(
              //                     scrollDirection: Axis.vertical,
              //                     shrinkWrap: true,
              //                     itemBuilder: (context, index) {
              //                       return Text(
              //                           '${logActual!.logs![index].modelo}');
              //                     },
              //                     itemCount: logActual?.logs?.length ?? 0,
              //                   ),
              //                 );
              //               }
              //             },
              //           ),
              //         ),
              //       )
              //     : Center(
              //         child: Text(
              //           '',
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontFamily: ColorTheme.fontFamily,
              //               fontSize: 14),
              //         ),
              //       ),
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
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              Container(
                width: responsive.wp(100), //500.0,
                height: responsive.hp(20),
                color: Colors.white60,
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                child: Container(
                  color: Colors.white60,
                  child: Container(
                    width: responsive.wp(40),
                    height: responsive.wp(40),
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
                                (a, b) => a.psi!.compareTo(b.rfc!),
                              );
                            },
                          );
                          break;
                        case 2:
                          setState(
                            () {
                              listaMedidoresUser!.sort(
                                (a, b) => b.psi!.compareTo(a.rfc!),
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
              //Drawer
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
                                          .where(
                                            (element) => element.psi!
                                                .toLowerCase()
                                                .contains(
                                                  itemSeleccionado!
                                                      .toLowerCase(),
                                                ),
                                          )
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
                                              logActual =
                                                  listaMedidoresUser![index];
                                              Navigator.pop(context);
                                            },
                                            nameMedidor:
                                                listaMedidoresUser?[index].psi,
                                            //listaMedidoresUser![index].rfc!,
                                            subtitle:
                                                '${listaMedidoresUser?[index].concesion} - ${listaMedidoresUser?[index].rfc}',
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

              TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      elevation: 5,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: ((context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '¿ESTÁ SEGURO DE ELIMINAR SU CUENTA?',
                                  style: TextStyle(
                                    fontSize: responsive.dp(2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsive.dp(1.5),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Este será un proceso irreversible, asegúrese de querer llevar a cabo este proceso.',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: Responsive(context).dp(1.5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsive.dp(4),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    //TODO: implementar el api de eliminacion de cuenta
                                    onPressed: () {
                                      final loginProvider =
                                          Provider.of<LoginProvider>(context,
                                              listen: false);
                                      print('Eliminar cuenta');
                                      CatService()
                                          .delete(context, loginProvider.token)
                                          .then((value) {
                                        print('value $value');
                                        Message.showMessage(
                                            context: context,
                                            message:
                                                'Cuenta eliminada con éxito',
                                            color: const Color(0xff69C073));
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AuthScreen.routeName,
                                            (route) => false);
                                      });
                                    },
                                    child: const Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  },
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: const Text('Eliminar cuenta'))
            ],
          ),
        ),
      ),
    );
  }
}
