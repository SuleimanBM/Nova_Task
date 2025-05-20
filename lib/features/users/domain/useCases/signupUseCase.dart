// domain/usecases/sign_up_usecase.dart
import '../entities/user.dart';
import '../repositories/authRepository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> execute(String name, String email, String password) {
    return repository.signUp(name, email, password);
  }
}
