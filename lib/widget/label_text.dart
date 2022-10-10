// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:telemetria/theme/theme.dart';

class LabelText extends StatelessWidget {
  final String txtValor;
  final double fontSize;
  final TextAlign alineation;

  Color? colorText;

  LabelText(
      {Key? key,
      required this.txtValor,
      required this.fontSize,
      this.alineation = TextAlign.center,
      this.colorText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      txtValor,
      textAlign: alineation,
      style: TextStyle(
        color: colorText ?? ColorTheme.thetextColor,
        fontSize: fontSize,
        fontFamily: ColorTheme.fontFamily,
      ),
    );
  }
}
