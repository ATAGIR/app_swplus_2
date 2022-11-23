import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:telemetria/models/medidor_user.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/image_background.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/label_text.dart';
import 'package:telemetria/widget/searchtextform.dart';
import 'package:telemetria/widget/spacer.dart';

class RfcPage extends StatefulWidget {
  static const routeName = 'RfcPage';
  const RfcPage(
      {Key? key, this.rfc, this.token, this.detalleLog, this.consecion})
      : super(key: key);

  final String? consecion;
  final String? rfc;
  final String? token;
  final List<Log>? detalleLog;

  @override
  State<RfcPage> createState() => _RfcPageState();
}

int? orderCat;
String? selectItem;
List<Log> logList = [];

const Map<String, int> consecionOrder = {
  "Conseción, A-Z": 1,
  "Conseción, Z-A": 2,
};

class _RfcPageState extends State<RfcPage> {
  @override
  void initState() {
    logList = widget.detalleLog!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.lightBlue.shade900,
          title: Row(
            children: [
              Text(
                widget.consecion!,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: responsive.dp(2),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade300,
                size: responsive.dp(1.6),
              ),
              Text(
                widget.rfc!,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: responsive.dp(2),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SpacerSW(isVertical: true, space: 2),
              SearchTextForm(
                width: responsive.wp(90),
                height: responsive.hp(5),
                borderColor: ColorTheme.iconsColor,
                backgroundColor: ColorTheme.thetextBackgroundColor,
                labelText: ' Buscar',
                onPressed: () {},
                iconSize: responsive.dp(2.1),
                onChanged: (value) {
                  List<Log> result = [];

                  if (value.isEmpty) {
                    result = widget.detalleLog!;
                  } else {
                    result = widget.detalleLog!
                        .where((element) => element.nsut!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    logList = result;
                  });
                },
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
                      'Orden',
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
                    value: orderCat,
                    onChanged: (int? value) {
                      orderCat = value!;
                      switch (orderCat) {
                        case 1:
                          setState(
                            () {
                              logList.sort(
                                ((a, b) => a.nsut!.compareTo(b.nsut!)),
                              );
                            },
                          );
                          break;
                        case 2:
                          setState(
                            () {
                              logList.sort(
                                ((a, b) => b.nsut!.compareTo(a.nsut!)),
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
              widget.detalleLog!.length != 0
                  ? SizedBox(
                      height: responsive.hp(70),
                      child: SingleChildScrollView(
                        child: SlideInLeft(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: logList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          try {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PageMapa(
                                                  latitud: logList[index].lat!,
                                                  longitud:
                                                      logList[index].long!,
                                                  nsut: logList[index].nsut!,
                                                  etiqueta:
                                                      logList[index].etiqueta!,
                                                  token: widget.token!,
                                                ),
                                              ),
                                            );
                                          } catch (e) {
                                            rethrow;
                                          }
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
                                                      'NSUT: ${logList[index].nsut}',
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
                                                                latitud: widget
                                                                    .detalleLog![
                                                                        index]
                                                                    .lat!,
                                                                longitud: widget
                                                                    .detalleLog![
                                                                        index]
                                                                    .long!,
                                                                nsut: widget
                                                                    .detalleLog![
                                                                        index]
                                                                    .nsut!,
                                                                etiqueta: widget
                                                                    .detalleLog![
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
                                                      icon: Icon(
                                                          Icons.location_on,
                                                          size: responsive
                                                              .dp(3.2),
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Etiqueta: ${logList[index].etiqueta!.trim()}\nModelo: ${logList[index].modelo}\nNSM: ${logList[index].nsm}\nNSM: ${logList[index].nsue}',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  responsive
                                                                      .dp(1.3),
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
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
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
                                fontSize: responsive.dp(1.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
