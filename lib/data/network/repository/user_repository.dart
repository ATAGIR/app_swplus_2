import 'package:dio/dio.dart';
import 'package:telemetria/models/medidor_model.dart';
import 'package:telemetria/data/network/api/dio_exception.dart';
import 'package:telemetria/data/network/api/user_api.dart';


class UserRepository {
  final UserApi userApi;

  UserRepository(this.userApi);

  Future<List<MedidorModel>> getUsersRequested() async {
    try {
      final response = await userApi.getUsersApi();
      final users = (response.data['data'] as List)
          .map((e) => MedidorModel.fromJson(e))
          .toList();
      return users;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  

  

  
}
