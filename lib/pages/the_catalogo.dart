import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/models/medidor_user.dart';
import 'package:telemetria/pages/login.dart';
import 'package:telemetria/pages/rfc_page.dart';
import 'package:telemetria/providers/login_prov.dart';
import 'package:telemetria/services/cat_service.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/message.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/utils/secure_storage.dart';
import 'package:telemetria/widget/neumorphism.dart';
import 'package:telemetria/widget/spacer.dart';

class TheCatalogo extends StatefulWidget {
  static const routeName = 'TheCatalogo';
  const TheCatalogo({Key? key, this.token, this.role, this.username})
      : super(key: key);

  final String? token;
  final String? role;
  final String? username;

  @override
  State<TheCatalogo> createState() => _TheCatalogoState();
}

bool emptyArray = true;

String? itemSeleccionado;

int? orderDrawer;

Future<List<MedidorUser>?>? _medidorUser;
List<MedidorUser>? listaMedidoresUser;

const Map<String, int> consecionOrder = {
  "Conseción, A-Z": 1,
  "Conseción, Z-A": 2,
};

class _TheCatalogoState extends State<TheCatalogo> {
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
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(70.0),
              bottomRight: Radius.circular(70.0)),
          child: Drawer(
            backgroundColor: Colors.lightBlue.shade900,
            child: Column(
              children: [
                NeumorphismSW(responsive: responsive),
                const SpacerSW(isVertical: true, space: 4),
                Column(
                  children: [
                    SizedBox(
                      height: responsive.hp(40),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 10),
                            child: Text(
                              widget.username!.trim(),
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: responsive.dp(2.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 10),
                            child: Text(
                              widget.role!.trim(),
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: responsive.dp(2.5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        onPressed: () {
                          SecureStorage().deleteSecureData('token');
                          SecureStorage().deleteSecureData('username');
                          SecureStorage().deleteSecureData('password');
                          Navigator.pushNamedAndRemoveUntil(
                              context, Login.routeName, (route) => false);
                        },
                        icon: Icon(Icons.exit_to_app_rounded,
                            color: Colors.grey.shade300),
                        label: Text(
                          'Salir',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: responsive.dp(2.5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextButton.icon(
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
                                    const SpacerSW(
                                        isVertical: true, space: 1.5),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Este será un proceso irreversible, asegúrese de querer llevar a cabo este proceso.',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize:
                                                Responsive(context).dp(1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SpacerSW(isVertical: true, space: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            final loginProvider =
                                                Provider.of<LoginProvider>(
                                                    context,
                                                    listen: false);
                                            CatService()
                                                .delete(context,
                                                    loginProvider.token)
                                                .then((value) {
                                              Message.showMessage(
                                                  context: context,
                                                  message:
                                                      'Cuenta eliminada con éxito',
                                                  color:
                                                      const Color(0xff69C073));
                                              SecureStorage()
                                                  .deleteSecureData('token');
                                              SecureStorage()
                                                  .deleteSecureData('username');
                                              SecureStorage()
                                                  .deleteSecureData('password');
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Login.routeName,
                                                  (route) => false);
                                            });
                                          },
                                          child: const Text(
                                            'Eliminar',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancelar',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                        icon: Icon(Icons.delete_forever_outlined,
                            color: Colors.grey.shade300),
                        label: Text(
                          'Eliminar cuenta',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: responsive.dp(2.5),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: Text(
            'InfoPro',
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: responsive.dp(2.5),
            ),
          ),
        ),
        body: Column(
          children: [
            const SpacerSW(isVertical: true, space: 2),
            Text(
              'Seleccione un PSI',
              style: TextStyle(
                  color: Colors.black54, fontSize: responsive.dp(1.8)),
            ),
            
            _medidorUser != null
                ? SingleChildScrollView(
                    child: SizedBox(
                      height: responsive.hp(80),
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
                                                itemSeleccionado!.toLowerCase(),
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
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: listaMedidoresUser![index]
                                                        .concesion ==
                                                    '' &&
                                                listaMedidoresUser![index]
                                                    .logs!
                                                    .isEmpty
                                            ? const EdgeInsets.all(5.0)
                                            : const EdgeInsets.only(
                                                right: 5.0,
                                                left: 40.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (listaMedidoresUser![index]
                                                        .concesion ==
                                                    '' &&
                                                listaMedidoresUser![index]
                                                    .logs!
                                                    .isEmpty) {
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => RfcPage(
                                                    consecion:
                                                        listaMedidoresUser![
                                                                index]
                                                            .concesion,
                                                    token: widget.token!,
                                                    rfc: listaMedidoresUser![
                                                            index]
                                                        .rfc,
                                                    detalleLog:
                                                        listaMedidoresUser![
                                                                index]
                                                            .logs!,
                                                    username: widget.username,
                                                    role: widget.role,
                                                  ),
                                                ),
                                              );
                                              //print('Se puede puchar');
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: listaMedidoresUser![
                                                                    index]
                                                                .concesion ==
                                                            '' &&
                                                        listaMedidoresUser![
                                                                index]
                                                            .logs!
                                                            .isEmpty
                                                    ? const Color(0xfff7f5bc)
                                                    : ColorTheme
                                                        .thetextBackgroundColor),
                                            height: responsive.hp(12),
                                            alignment: Alignment.centerLeft,
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(
                                                      Icons.circle,
                                                      size: responsive.dp(1.2),
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 20, 61, 133),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        listaMedidoresUser![index]
                                                                        .concesion ==
                                                                    '' &&
                                                                listaMedidoresUser![
                                                                        index]
                                                                    .logs!
                                                                    .isEmpty
                                                            ? listaMedidoresUser![
                                                                    index]
                                                                .psi!
                                                            : listaMedidoresUser![
                                                                            index]
                                                                        .concesion ==
                                                                    ''
                                                                ? listaMedidoresUser![
                                                                        index]
                                                                    .psi!
                                                                : listaMedidoresUser![
                                                                        index]
                                                                    .concesion!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                ColorTheme
                                                                    .fontFamily,
                                                            fontSize: responsive
                                                                .dp(2)),
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                  ),
                                                  listaMedidoresUser![index]
                                                                  .concesion ==
                                                              '' &&
                                                          listaMedidoresUser![
                                                                  index]
                                                              .logs!
                                                              .isEmpty
                                                      ? Icon(
                                                          Icons.arrow_drop_down,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              22, 110, 243),
                                                          size:
                                                              responsive.dp(4))
                                                      : IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RfcPage(
                                                                  consecion: listaMedidoresUser![
                                                                          index]
                                                                      .concesion,
                                                                  token: widget
                                                                      .token!,
                                                                  rfc: listaMedidoresUser![
                                                                          index]
                                                                      .rfc,
                                                                  detalleLog:
                                                                      listaMedidoresUser![
                                                                              index]
                                                                          .logs!,
                                                                  username: widget
                                                                      .username,
                                                                  role: widget
                                                                      .role,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    22,
                                                                    110,
                                                                    243),
                                                          ),
                                                        )
                                                ],
                                              ),
                                              subtitle: Text(
                                                listaMedidoresUser![index]
                                                                .concesion ==
                                                            '' &&
                                                        listaMedidoresUser![
                                                                index]
                                                            .logs!
                                                            .isEmpty
                                                    ? ''
                                                    : listaMedidoresUser![index]
                                                        .rfc!,
                                                style: TextStyle(
                                                    fontSize:
                                                        responsive.dp(1.5),
                                                    color: ColorTheme
                                                        .thetextColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
          ],
        ),
      ),
    );
  }
}
