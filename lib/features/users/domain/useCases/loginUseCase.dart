// domain/usecases/login_usecase.dart
import '../entities/user.dart';
import '../repositories/authRepository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> execute(String email, String password) {
    final response = repository.login(email, password);
    return response;
  }
}
