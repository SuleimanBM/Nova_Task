// data/repositories/auth_repository_impl.dart
import 'package:nova_task/features/users/data/dataSources/remoteUserDataSource.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/authRepository.dart';
import '../datasources/remoteUserDataSource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> signUp(String name, String email, String password) {
    return remoteDataSource.signUp(name, email, password);
  }

  @override
  Future<User> login(String name, String email, String password) {
    return remoteDataSource.login(name, email, password);
  }
}
