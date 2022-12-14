// ignore_for_file: prefer_is_empty, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/pages/auth_screen.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/pages/the_catalogo.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/image_background.dart';
import 'package:telemetria/utils/message.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/utils/secure_storage.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/listtile_telemetria.dart';
import 'package:telemetria/widget/searchtextform.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class Catalogo extends StatefulWidget {
  static const routeName = 'Catalogo';
  const Catalogo({
    super.key,
    this.token,
    this.username,
    this.role,
  });
  final String? token;
  final String? role;
  final String? username;
  @override
  State<Catalogo> createState() => _CatalogoState();
}

int? orderDrawer;
int? orderCat;
Future<List<MedidorUser>?>? _medidorUser;
List<MedidorUser>? listaMedidoresUser;
bool emptyArray = true;
bool arrayVacio = true;
String? itemSeleccionado;
String? selectItem;
List<Log>? logList;

const Map<String, int> consecionOrder = {
  "Conseción, A-Z": 1,
  "Conseción, Z-A": 2,
};

const Map<String, int> modelOrder = {
  "Modelo, A-Z": 1,
  "Modelo, Z-A": 2,
};

class _CatalogoState extends State<Catalogo> {
  MedidorUser? logActual;
  @override
  void initState() {
    super.initState();
    _medidorUser = CatService().getLast(context, widget.token!);
    logList = [];
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SearchTextForm(
          //     width: responsive.wp(60),
          //     height: responsive.hp(5),
          //     borderColor: ColorTheme.iconsColor,
          //     backgroundColor: ColorTheme.thetextBackgroundColor,
          //     labelText: 'Buscar',
          //     onPressed: () {},
          //     iconSize: responsive.dp(2.1),
          //     onChanged: (value) {
          //       setState(
          //         () {
          //           if (value.isEmpty) {
          //             arrayVacio = true;
          //             selectItem = value.trim();
          //           } else {
          //             arrayVacio = false;
          //             selectItem = value.trim();
          //           }
          //         },
          //       );
          //     },
          //   ),
          // ),
          SizedBox(width: responsive.wp(6)),
          IconButton(
            onPressed: () {
              SecureStorage().deleteSecureData('token');
              SecureStorage().deleteSecureData('username');
              SecureStorage().deleteSecureData('password');
              // Navigator.pushNamedAndRemoveUntil(
              //     context, Login.routeName, (route) => false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TheCatalogo(
                    token: widget.token,
                    role: widget.role,
                    username: widget.username,
                  ),
                ),
              );
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
            children: <Widget>[
              SizedBox(
                height: responsive.hp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LabelText(
                    txtValor: 'NSUT',
                    fontSize: responsive.dp(1.8),
                    colorText: Colors.black54,
                  ),
                  DropdownButton<int>(
                    hint: Text(
                      'Ordenar por',
                      style: TextStyle(color: ColorTheme.thetextColor),
                    ),
                    style: TextStyle(color: ColorTheme.thetextColor),
                    items: modelOrder
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
                    value: orderCat,
                    onChanged: (int? value) {
                      orderCat = value!;
                      switch (orderCat) {
                        case 1:
                          setState(
                            () {
                              logList!
                                  .sort(((a, b) => a.nsut!.compareTo(b.nsut!)));
                            },
                          );
                          break;
                        case 2:
                          setState(
                            () {
                              logList!
                                  .sort(((a, b) => b.nsut!.compareTo(a.nsut!)));
                            },
                          );
                          break;
                        default:
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: logActual?.psi == null
                    ? Text(
                        'Seleccione un PSI',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: responsive.dp(1.8)),
                      )
                    : Text(
                        '${logActual?.psi} > ${logActual?.concesion} > ${logActual?.rfc}',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: responsive.dp(1.8)),
                      ),
              ),
              logList!.length != 0
                  ? SizedBox(
                      height: responsive.hp(75),
                      child: FutureBuilder<List<Log>?>(builder:
                          (context, AsyncSnapshot<List<Log>?> snapshot) {
                        arrayVacio
                            ? logList = logList
                            : logList = logList!
                                .where(
                                  (element) =>
                                      element.nsut!.toLowerCase().contains(
                                            selectItem!.toLowerCase(),
                                          ),
                                )
                                .toList();
                        return SingleChildScrollView(
                          child: SlideInLeft(
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: logList!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              barrierColor: Colors.black87,
                                              context: context,
                                              builder: (context) {
                                                DateTime? now =
                                                    logList![index].fecha;
                                                String formattedDate = DateFormat(
                                                        ' dd-MM-yyyy – kk:mm')
                                                    .format(now!);
                                                return Center(
                                                  child: SizedBox(
                                                    height: responsive.hp(33),
                                                    width: responsive.wp(92),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              responsive.hp(2),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Etiqueta: ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    '  ${logList![index].etiqueta}',
                                                                    style: const TextStyle(
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
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    '  ${logList![index].nsut}',
                                                                    style: const TextStyle(
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
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    formattedDate,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                ],
                                                              ),
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Modelo: ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    '  ${logList![index].modelo}',
                                                                    style: const TextStyle(
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
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    '  ${logList![index].nsm}',
                                                                    style: const TextStyle(
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
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    '  ${logList![index].nsue}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ) //
                                                                ],
                                                              )
                                                            ],
                                                          ),
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
                                              children: [
                                                ListTile(
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        'NSUT: ${logList![index].nsut}',
                                                        style: TextStyle(
                                                            fontSize: responsive
                                                                .dp(1.6)),
                                                      ),
                                                      const Spacer(),
                                                      IconButton(
                                                        onPressed: () {
                                                          try {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PageMapa(
                                                                  latitud: logList![
                                                                          index]
                                                                      .lat!,
                                                                  longitud: logList![
                                                                          index]
                                                                      .long!,
                                                                  nsut: logList![
                                                                          index]
                                                                      .nsut!,
                                                                  etiqueta: logList![
                                                                          index]
                                                                      .etiqueta!,
                                                                  token: widget
                                                                      .token!,
                                                                ),
                                                              ),
                                                            );
                                                          } catch (e) {
                                                            rethrow;
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.location_on,
                                                            size: 40,
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Modelo: ${logList![index].modelo}\nEtiqueta: ${logList![index].etiqueta!.trim()}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    responsive
                                                                        .dp(1.2),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
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
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : Container(
                      width: responsive.wp(100),
                      height: responsive.hp(55),
                      decoration: ImageBackground.imagebackground(opacity: 0.1),
                      child: Column(
                        children: [
                          SizedBox(
                            height: responsive.hp(10),
                          ),
                          Center(
                              child: Text(
                            'Sin Archivos',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: responsive.dp(1.8)),
                          )),
                        ],
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
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: responsive.hp(3.5),
              ),
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
              Text(
                'Usuario: ${widget.username!.trim()}\nRol: ${widget.role!.trim()}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: responsive.dp(1.7),
                  color: Colors.blue.shade400,
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
                    items: consecionOrder
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
                    value: orderDrawer,
                    onChanged: (int? value) {
                      orderDrawer = value!;
                      switch (orderDrawer) {
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
                                child: RefreshIndicator(
                                  edgeOffset: 1.0,
                                  displacement: 40.0,
                                  onRefresh: () {
                                    setState(
                                      () {},
                                    );
                                    return _medidorUser = CatService()
                                        .getLast(context, widget.token!);
                                  },
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTileTelemetria
                                          .listTileTELEMETRIA(
                                              buttonText: false,
                                              circleColor:
                                                  ColorTheme.indicatorColor,
                                              iconButton2:
                                                  Icons.arrow_forward_ios,
                                              onPressarrowButton: () {
                                                logActual =
                                                    listaMedidoresUser![index];
                                                logList =
                                                    listaMedidoresUser![index]
                                                        .logs;
                                                Navigator.pop(context);
                                              },
                                              nameMedidor:
                                                  listaMedidoresUser?[index]
                                                      .psi,
                                              subtitle:
                                                  '${listaMedidoresUser?[index].concesion} - ${listaMedidoresUser?[index].rfc}',
                                              responsive: responsive,
                                              iconButton1: Icons.abc,
                                              textButton: 'Ver');
                                    },
                                    itemCount: listaMedidoresUser!.length,
                                  ),
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
              SizedBox(
                height: Responsive(context).wp(0.1),
              ),
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
