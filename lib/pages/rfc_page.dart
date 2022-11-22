import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:telemetria/models/medidor_user.dart';
import 'package:telemetria/pages/page_mapa.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/utils/image_background.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/spacer.dart';

class RfcPage extends StatefulWidget {
  static const routeName = 'RfcPage';
  const RfcPage(
      {Key? key,
      this.rfc,
      this.token,
      this.detalleLog,
      this.username,
      this.role,
      this.consecion})
      : super(key: key);

  final String? consecion;
  final String? rfc;
  final String? token;
  final List<Log>? detalleLog;
  final String? username;
  final String? role;

  @override
  State<RfcPage> createState() => _RfcPageState();
}

Future<List<MedidorUser>?>? _medidorUser;
List<Log>? logList;

class _RfcPageState extends State<RfcPage> {
  @override
  void initState() {
    super.initState();
    _medidorUser = CatService().getLast(context, widget.token!);
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
        body: Column(
          children: [
            const SpacerSW(isVertical: true, space: 2),
            widget.detalleLog!.length != 0
                ? SizedBox(
                    height: responsive.hp(85),
                    child: FutureBuilder<List<Log>?>(
                      builder: (context, AsyncSnapshot<List<Log>?> snapshot) {
                        return SingleChildScrollView(
                          child: SlideInLeft(
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: widget.detalleLog!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            try {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageMapa(
                                                    latitud: widget
                                                        .detalleLog![index]
                                                        .lat!,
                                                    longitud: widget
                                                        .detalleLog![index]
                                                        .long!,
                                                    nsut: widget
                                                        .detalleLog![index]
                                                        .nsut!,
                                                    etiqueta: widget
                                                        .detalleLog![index]
                                                        .etiqueta!,
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
                                                        'NSUT: ${widget.detalleLog![index].nsut}',
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
                                                              'Etiqueta: ${widget.detalleLog![index].etiqueta!.trim()}\nModelo: ${widget.detalleLog![index].modelo}\nNSM: ${widget.detalleLog![index].nsm}\nNSM: ${widget.detalleLog![index].nsue}',
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
                        );
                      },
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
                                fontSize: responsive.dp(1.8)),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
