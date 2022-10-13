// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ConfigureApi {
  static final ConfigureApi _configureApi = ConfigureApi._internal();
  factory ConfigureApi() {
    return _configureApi;
  }
  ConfigureApi._internal();
  static const base_url = "http://infopro-api.swplus.com.mx/api/log/";

  static BaseOptions options = BaseOptions(
    baseUrl: base_url,
    connectTimeout: 120000,
    receiveTimeout: 120000,
    receiveDataWhenStatusError: true,
    responseType: ResponseType.plain,
  );
}
