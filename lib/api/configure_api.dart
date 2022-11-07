// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ConfigureApi {
  static final ConfigureApi _configureApi = ConfigureApi._internal();
  factory ConfigureApi() {
    return _configureApi;
  }
  ConfigureApi._internal();
  static const base_url = "http://infopro-api.swplus.com.mx/api";

  static BaseOptions options = BaseOptions(
    baseUrl: base_url,
    connectTimeout: 120000,
    receiveTimeout: 120000,
    receiveDataWhenStatusError: true,
    responseType: ResponseType.plain,
  );

  static const String mapBoxUrl =
      "https://api.mapbox.com/styles/v1/israel1993/cla7d3dvj000914pqucdgrhfg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXNyYWVsMTk5MyIsImEiOiJjbDhrZHI1MWowNzlqM3h0b3h5amF5MndzIn0.8P03IKbKUQh6wSeu6Dz_Ig";
  static const String mapBoxAccessToken = 'TOKEN';
  static const String mapBoxStyleId = 'ID';
}
