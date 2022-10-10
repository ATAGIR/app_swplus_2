import 'package:flutter/material.dart';
import 'package:telemetria/utils/caracteres.dart';

import '../utils/responsive.dart';
import 'login.dart';



class RegistroLogin extends StatefulWidget {
  const RegistroLogin({Key? key}) : super(key: key);
  static String id = 'Registrarse';

  @override
  State<RegistroLogin> createState() => _RegistroLoginState();
}

class _RegistroLoginState extends State<RegistroLogin> {
  String username = '';
  String email = '';
  String password = '';
  String confirmarPassword = '';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
           onTap: (){
            FocusScopeNode currentFocus =
              FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Form(

                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Image.asset('assets/imagenes/logo.jpeg',
                    height: responsive.hp(30),
                    width: responsive.wp(65),
                    ),
                    _userTextField(),
                      SizedBox(height: Responsive(context).wp(5)
                      ),
                      _emailTextField(),
                      SizedBox(height: Responsive(context).wp(5)
                      ),
                      _passwordTextField(),
                      SizedBox(height: Responsive(context).wp(5)
                      ),
                       _passwordCTextField(),
                      SizedBox(height: Responsive(context).wp(5)
                      ),
                          _botonRegistrarse(),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
  
  Widget _userTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).hp(4)),
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
          validator: (text){
            if (text!.trim().length < 5){
              return 'Usuario invalido';
            }
            return null;
          },
          ),
        );
      }
    );
  }
  
  Widget _emailTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).hp(4)),
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
          validator: (value){
            return Caracteres().validaCorreo(value!);
          }
          ),
        );
      }
    );
  }
  
  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive(context).hp(4)),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: Icon(Icons.lock_rounded),
            hintText: 'Ingrese una contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (value) => password = value.trim(),
          validator: (value){
            if (value != null && value.length >=5){
              return null;
            } else {
              return 'Verifique su contraseña';
            }
          }
          ),
        );
      }
    );
  }
  
  Widget _passwordCTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive(context).hp(4)),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            icon: Icon(Icons.lock_rounded),
            hintText: 'Confirmar contraseña',
            labelText: 'Confirmar contraseña',
          ),
          onChanged: (value) => confirmarPassword = value.trim(),
          validator: (value){
            if (value != null && value.length >= 5){
              return null;
            } else{
              return 'Verifique su contraseña';
            }
          }
          ),
        );
      }
    );
  }
  
  Widget _botonRegistrarse() {
   return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
      onPressed: () {
        Navigator.pop(context, MaterialPageRoute(builder: (context)=>  const Login()));

      },
      child: SizedBox(
          width: Responsive(context).wp(30), height: Responsive(context).hp(7), 
          child: const Center(child: Text('Registrarse'))),
    );
  }
}