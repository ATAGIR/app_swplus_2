import 'package:flutter/material.dart';
import 'package:telemetria/data/di/service_locator.dart';
import 'package:telemetria/data/models/medidor_model.dart';
import 'package:telemetria/data/network/repository/user_repository.dart';

class HomeController {
  // --------------- Repository -------------
  final userRepository = getIt.get<UserRepository>();

  // -------------- Textfield Controller ---------------
  final nameController = TextEditingController();
  final jobController = TextEditingController();


 
  // -------------- Methods ---------------

  Future<List<MedidorModel>> getUsers() async {
    final users = await userRepository.getUsersRequested();
    return users;
  }

  
}
