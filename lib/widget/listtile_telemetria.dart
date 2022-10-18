import 'package:flutter/material.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';
import 'package:telemetria/widget/widButton.dart';

class ListTileTelemetria {
  static ClipRRect listTileTELEMETRIA({
    required Responsive responsive,
    required Color circleColor,
    required IconData iconButton1,
    required IconData iconButton2,
    required String textButton,
    required String nameMedidor,
    required bool buttonText,
    bool arrowButton = true,
    String subtitle = '',
    required Function() onPressButton1,
    required Function() onPressButton2,
    required Function() onPressarrowButton,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorTheme.thetextBackgroundColor),
          height: responsive.hp(10),
          alignment: Alignment.centerLeft,
          child: ListTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(Icons.circle,
                      size: responsive.dp(1.2), color:const Color.fromARGB(255, 20, 61, 133)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      nameMedidor,
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: ColorTheme.fontFamily,
                          fontSize: 14),
                    ),
                  ),
                ),
                buttonText
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: WidButton(
                            textButton: textButton,
                            height: responsive.hp(1.5),
                            width: responsive.wp(3),
                            onPressed: onPressButton1,
                            isBorder: false,
                            fontsizeText: 13),
                      )
                    : Container(
                        height: responsive.hp(6),
                        color: ColorTheme.thebuttonsColor,
                        child: IconButton(
                          onPressed: onPressButton2,
                          icon: Icon(
                            iconButton1,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            size: responsive.dp(3.5),
                          ),
                        ),
                      ),
                arrowButton
                    ? IconButton(
                        onPressed: onPressarrowButton,
                        icon: Icon(
                          iconButton2,
                          color: const Color.fromARGB(255, 22, 110, 243),
                        ))
                    : SizedBox(
                        width: responsive.wp(.5),
                      )
              ],
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: ColorTheme.thetextColor),
            ),
          ),
        ),
      ),
    );
  }
}
