// domain/usecases/login_usecase.dart
import '../entities/user.dart';
import '../repositories/authRepository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String name, String email, String password) {
    return repository.login(name, email, password);
  }
}
