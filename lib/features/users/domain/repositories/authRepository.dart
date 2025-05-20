// domain/repositories/auth_repository.dart
import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> signUp(String name, String email, String password);
  Future<void> login(String email, String password);
}
