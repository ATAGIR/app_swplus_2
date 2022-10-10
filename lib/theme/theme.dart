import 'package:flutter/material.dart';

class ColorTheme {
  static final ColorTheme _pscTheme = ColorTheme.internal();
  factory ColorTheme() {
    return _pscTheme;
  }

  ColorTheme.internal();
  // Fuente

  //Color Font InputText
  static Color textGray = const Color(0xff7B7B7B);
  static Color iconBackgroundColor = const Color(0xff98363A);
  static Color iconsColor = const Color.fromARGB(255, 51, 128, 6);
  static Color textButtonColor = const Color(0xffE15E63);
  static Color thetextColor = Colors.black;
  static Color thetextBackgroundColor = Colors.grey.shade200;
  static Color textCircularFimados = const Color.fromARGB(255, 86, 226, 184);

//Color Font Label Text
  static Color textColorAppBar = const Color(0xffE54B51);

// Color Button

  static Color thebuttonsColor = const Color(0xff98363A);
  static Color buttonsBorderColor = const Color(0xffA85255);
  static Color buttonbackgroudColor = const Color.fromARGB(255, 30, 30, 30);
  static Color menuButtonsColor = const Color(0xff303030);

// Color estatus  del proceso de firma
  static Color theColorEstatus = const Color.fromARGB(182, 152, 54, 57);

  //agregar documento Color
  static Color addTheDocument = const Color(0xff404040);

//scalfold
  static Color backgroudColor = const Color(0xff1E1E1E);
  // Colors.black;

//Color Ink
  static Color borderInk = const Color(0xffE54B51);

//Text buttonColor
  static Color textButtonGray = const Color(0xffDBDBDB);
// Border Icon outlined
  static Color iconOutlined = const Color(0xffBF4045);

// Rubrica
  static Color labeltextRubrica = const Color(0xffD8D8D8);

  // text mifiel #676767
  static Color fielText = const Color(0xff676767);
  //modal colorText

  static Color modalColorText = const Color(0xff111111);

  static Color serchBarColorText = const Color(0xffB1B1B1);

// Colors Bullets Nuevo Folio
  static Color nuevoFolio = const Color(0xff6FB9F9);

  static Color theYellow = const Color.fromARGB(255, 248, 185, 44);
  static Color theGreen = const Color.fromARGB(255, 86, 226, 184);
  static Color formContainer = const Color.fromARGB(255, 42, 42, 42);
  static Color textFormContainer = const Color.fromARGB(255, 112, 112, 112);
  static Color buttonsOpacity = const Color.fromARGB(255, 50, 50, 50);
  static Color snackBarColor = const Color.fromARGB(255, 23, 23, 23);
  static Color snackBarColorTransparent = const Color.fromARGB(0, 23, 23, 23);

  static Color appbarBackground = const Color(0xff2A2A2A);

  static String fontFamily = 'VictorMono';

//DashBoard

  static Color backgroundDashBoard = const Color(0xff171717);
  static Color indicatorColor = const Color(0xff56E2B8);
  static Color indicatorColorFirmadosBack = Colors.white24;
  //static Color indicatorColorFirmadosBack = Color.fromARGB(247, 218, 244, 237);
  static Color indicatorColorporFirmar = const Color(0xffFFD77E);
  static Color indicatorColorporFirmarBack = Colors.white24;
  //static Color indicatorColorporFirmarBack = Color.fromARGB(249, 244, 235, 214);
  static Color indicatorColorborradores = const Color(0xff6FB9F8);
  //static Color indicatorColorborradoresBack = Color.fromARGB(252, 205, 225, 244);
  static Color indicatorColorborradoresBack = Colors.white24;

  static Color addDocumentColor = const Color(0xff9C9C9C);

//  Alerts
  static Color fail = const Color(0xffBF4045);
  static Color warning = const Color(0xffF9A200);
  static Color sucess = const Color(0xff69C073);

  // rechazar Button
  static Color rechazarButton = const Color(0xff090909);
}
