// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ConfigureApi {
  static final ConfigureApi _configureApi = ConfigureApi._internal();
  factory ConfigureApi() {
    return _configureApi;
  }
  ConfigureApi._internal();
  static const base_url = "http://infopro-api.swplus.com.mx/api/";

  static BaseOptions options = BaseOptions(
    baseUrl: base_url,
    connectTimeout: 120000,
    receiveTimeout: 120000,
    receiveDataWhenStatusError: true,
    responseType: ResponseType.plain,
  );

  static const String mapBoxUrl =
      "https://api.mapbox.com/styles/v1/swplus-tecnologias/cl97725qz001t14qlh4h5el6d/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3dwbHVzLXRlY25vbG9naWFzIiwiYSI6ImNsOGtheXV3aDBhbW80MHBpbWdncHFjM2YifQ.G3Yg7SECTj4nvAAoK4DuaA";
  static const String mapBoxAccessToken = 'TOKEN';
  static const String mapBoxStyleId = 'ID';
}
