import 'package:flutter/material.dart';
import 'package:telemetria/pages/login.dart';
import 'package:telemetria/services/registro_serv.dart';
import 'package:telemetria/utils/caracteres.dart';
import 'package:telemetria/utils/message.dart';
import 'package:telemetria/utils/responsive.dart';

class FormRegistro extends StatefulWidget {
  const FormRegistro({super.key});

  @override
  State<FormRegistro> createState() => _FormRegistroState();
}

class _FormRegistroState extends State<FormRegistro> {
  final GlobalKey<FormState> _regKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  bool passwordVisible = true;
  String username = '';
  String email = '';
  String password = '';
  String confirmarPassword = '';

  _submit() {
    final isOk = _regKey.currentState!.validate();
    if (isOk) {
      RegistroServ().registroUsr(context, username, email, password,3);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.asset(
                    'assets/imagenes/InfoPro.png',
                    height: responsive.hp(30),
                    width: responsive.wp(65),
                  ),
                  _userTextField(),
                  SizedBox(height: Responsive(context).wp(5)),
                  _emailTextField(),
                  SizedBox(height: Responsive(context).wp(5)),
                  _passwordTextField(),
                  SizedBox(height: Responsive(context).wp(5)),
                  _passwordCTextField(),
                  SizedBox(height: Responsive(context).wp(5)),
                  _botonRegistrarse(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: Icon(Icons.person),
            hintText: 'Ingrese un usuario',
            labelText: 'Nombre de usuario',
          ),
          onChanged: (text) {
            username = text;
          },
          validator: (text) {
            if (text!.trim().length < 5) {
              return 'Usuario invalido';
            }
            return null;
          },
        ),
      );
    });
  }

  Widget _emailTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              icon: Icon(Icons.email),
              hintText: 'Ingrese correo electronico',
              labelText: 'Correo electronico',
            ),
            onChanged: (value) => email = value.trim(),
            validator: (value) {
              return Caracteres().validaCorreo(value!);
            }),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              icon: const Icon(Icons.lock_rounded),
              hintText: 'Ingrese una contraseña',
              labelText: 'Contraseña',
            ),
            onChanged: (value) => password = value.trim(),
            validator: (value) {
              if (value != null && value.length >= 5) {
                return null;
              } else {
                return 'Verifique su contraseña';
              }
            }),
      );
    });
  }

  Widget _passwordCTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).hp(4)),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              icon: const Icon(Icons.lock_rounded),
              hintText: 'Confirmar contraseña',
              labelText: 'Confirmar contraseña',
            ),
            onChanged: (value) => confirmarPassword = value.trim(),
            validator: (value) {
              if (value != null && value.length >= 5) {
                return null;
              } else {
                return 'Verifique su contraseña';
              }
            }),
      );
    });
  }

  Widget _botonRegistrarse() {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
      onPressed: () {
        FocusScope.of(context).unfocus();
        _submit;
        if (username.isEmpty) {
          Message.showMessage(
              context: context,
              message:
                  '  Se require completar la información solicitada, verifique',
              color: const Color.fromARGB(255, 191, 64, 69));
          return;
        }

        if (email.isEmpty) {
          Message.showMessage(
              context: context,
              message: 'El correo no es valido',
              color: const Color(0xffBF4045));
          return;
        }
        if (password.isEmpty) {
          Message.showMessage(
              context: context,
              message: 'La contraseña debe de ser minimo 5 caracteres',
              color: const Color(0xffBF4045));
          return;
        }

        RegistroServ()
            .registroUsr(context, username, email, password,3)
            .then((value) {
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => const Login()));
        });
      },
      child: SizedBox(
          width: Responsive(context).wp(30),
          height: Responsive(context).hp(7),
          child: const Center(child: Text('Registrarse'))),
    );
  }
}
