import 'package:flutter/material.dart';

class ImageBackground {
  static BoxDecoration imagebackground({required double opacity}) {
    return BoxDecoration(
        image: DecorationImage(
            image: const AssetImage('assets/imagenes/InfoPro.png'),
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            opacity: opacity));
  }
}
