import 'package:flutter/material.dart';
import 'package:telemetria/theme/theme.dart';
import 'package:telemetria/utils/responsive.dart';


class ListTileTelemetria {
  static ClipRRect listTileTELEMETRIA({
    required Responsive responsive,
    required Color circleColor,
    IconData? iconButton1,
    IconData? iconButton2,
    String? textButton,
    required String? nameMedidor,
    required bool buttonText,
    bool arrowButton = true,
    String subtitle = '',
    Function()? onPressButton1,
    Function()? onPressButton2,
    Function()? onPressarrowButton,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: onPressarrowButton,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorTheme.thetextBackgroundColor),
            height: responsive.hp(12),
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
                        nameMedidor!,
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: ColorTheme.fontFamily,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  buttonText
                      ? const Padding(
                          padding: EdgeInsets.all(2.0),
                          
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
      ),
    );
  }
}
