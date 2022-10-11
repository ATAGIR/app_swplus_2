// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:telemetria/models/models.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/listtile_telemetria.dart';
import 'package:telemetria/widget/searchtextform.dart';
import 'package:animate_do/animate_do.dart';

import '../utils/secure_storage.dart';
import 'login.dart';

class Catalogo extends StatefulWidget {
  static const routeName = 'Catalogo';
  const Catalogo({super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

int? ordens;
Future<List<MedidorUser>?>? _medidorModel;
List<MedidorUser>? listMedidoresModel;

bool emptyArray = false;
String? itemMarcado;

const Map<String, int> itemOrdens = {
  "Folio, Ascendente": 1,
  "Folio, Descendente": 2,
  "Nombre, A-Z": 3,
  "Nombre, Z-A": 4,
};

class _CatalogoState extends State<Catalogo> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('salir');
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset(
              "assets/imagenes/logo_sw.png",
              height: 40.0,
            ),
            SizedBox(
              width: responsive.wp(3),
            ),
            SearchTextForm(
                width: responsive.wp(51.4),
                height: responsive.hp(5),
                borderColor: ColorTheme.iconsColor,
                backgroundColor: ColorTheme.thetextBackgroundColor,
                labelText: 'Buscar',
                onPressed: () {},
                iconSize: responsive.dp(1.8),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      emptyArray = true;
                    } else {
                      emptyArray = false;
                      itemMarcado = value.trim();
                    }
                  });
                }),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
            ),
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LabelText(
                    txtValor: 'Concecion',
                    fontSize: responsive.dp(1.8),
                    colorText: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  DropdownButton<int>(
                    hint: Text(
                      'Ordenar por',
                      style: TextStyle(color: ColorTheme.textGray),
                    ),
                    style: TextStyle(color: ColorTheme.textGray),
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
                      //print(ordens);
                      switch (ordens) {
                        case 1:
                          setState(
                            () {
                              listMedidoresModel!.sort(
                                (a, b) => a.psiId.compareTo(b.psiId),
                              );
                            },
                          );
                          break;
                        case 2:
                          setState(
                            () {
                              listMedidoresModel!.sort(
                                //(a, b) => b.soNumero.compareTo(a.soNumero),
                                (a, b) => b.psiId.compareTo(a.psiId),
                              );
                            },
                          );
                          break;
                        case 3:
                          setState(
                            () {
                              listMedidoresModel!.sort(
                                (a, b) => a.concesion
                                    .toString()
                                    .compareTo(b.concesion.toString()),
                              );
                            },
                          );
                          break;
                        case 4:
                          setState(
                            () {
                              listMedidoresModel!.sort(
                                (a, b) => b.concesion
                                    .toString()
                                    .compareTo(a.concesion.toString()),
                              );
                            },
                          );
                          break;
                        default:
                      }
                    },
                  )
                ],
              ),
              _medidorModel != null
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: responsive.hp(60),
                        width: responsive.wp(97),
                        child: FutureBuilder<List<MedidorUser>?>(
                          future: _medidorModel,
                          builder: (context,
                              AsyncSnapshot<List<MedidorUser>?> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              emptyArray
                                  ? {
                                      listMedidoresModel = snapshot.data,
                                    }
                                  : {
                                      listMedidoresModel = listMedidoresModel!
                                          .where((element) => element
                                              .razonSocial
                                              .toLowerCase()
                                              .contains(
                                                  itemMarcado!.toLowerCase()))
                                          .toList(),
                                    };
                              return SlideInLeft(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: listMedidoresModel!.length,
                                  itemBuilder: (context, index) {
                                    return ListTileTelemetria.listTileTELEMETRIA(
                                        buttonText: true,
                                        circleColor: ColorTheme.indicatorColor,
                                        iconButton1: Icons.abc,
                                        iconButton2: Icons.arrow_forward_ios,
                                        onPressarrowButton: () {},
                                        onPressButton1: () {},
                                        onPressButton2: () {},
                                        textButton: 'DownLoad',
                                        nameMedidor: listMedidoresModel![index]
                                            .concesion,
                                        subtitle:
                                            'Folio ${listMedidoresModel![index].concesion} Fecha Alta',
                                        responsive: responsive);
                                  },
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
              _bottonSalir(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottonSalir() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(''),
          TextButton(
            child: const Text("SALIR"),
            onPressed: () {
              SecureStorage().deleteSecureData('token');
              SecureStorage().deleteSecureData('username');
              SecureStorage().deleteSecureData('password');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          )
        ],
      );
}
