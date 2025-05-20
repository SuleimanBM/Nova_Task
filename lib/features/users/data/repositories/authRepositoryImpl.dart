// data/repositories/auth_repository_impl.dart

import '../../domain/entities/user.dart';
import '../../domain/repositories/authRepository.dart';
import '../datasources/remoteUserDataSource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signUp(String name, String email, String password) {
    return remoteDataSource.signUp(name, email, password);
  }

  @override
  Future<void> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }
}
