// domain/repositories/auth_repository.dart
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp(String name, String email, String password);
  Future<User> login(String name, String email, String password);
}
