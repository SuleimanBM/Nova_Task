// data/datasources/auth_remote_data_source_impl.dart
import 'dart:math';

import '../models/userModel.dart';


class  AuthRemoteDataSource {
  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // simulate network
    return UserModel(name: name, email: email, password: password);
  }

  @override
  Future<UserModel> login(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // simulate network
    return UserModel(name: '123', email: email, password: password);
  }
}
