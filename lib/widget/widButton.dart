// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:telemetria/theme/theme.dart';

class WidButton extends StatelessWidget {
  const WidButton({
    Key? key,
    required this.textButton,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.isBorder,
    required this.fontsizeText,
    this.textColor,
  }) : super(key: key);
  final String textButton;
  final double height;
  final double width;
  final double fontsizeText;
  final Color? textColor;
  final bool isBorder;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: isBorder ? ColorTheme.backgroudColor : ColorTheme.thebuttonsColor,
          shape: isBorder
              ? RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorTheme.buttonsBorderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                )
              : const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: EdgeInsets.symmetric(vertical: height, horizontal: width)),
      child: Text(
        textButton,
        style: TextStyle(
            fontSize: fontsizeText,
            color: textColor,
            fontFamily: ColorTheme.fontFamily,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
