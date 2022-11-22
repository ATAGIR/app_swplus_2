import 'package:flutter/material.dart';
import 'package:telemetria/utils/responsive.dart';

class NeumorphismSW extends StatelessWidget {
  const NeumorphismSW({
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: responsive.wp(100),
      height: responsive.hp(30),
      alignment: Alignment.center,
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
    );
  }
}
