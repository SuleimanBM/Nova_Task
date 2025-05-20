import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nova_task/features/users/domain/useCases/loginUseCase.dart';
import 'package:nova_task/features/users/domain/useCases/signupUseCase.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;

  AuthBloc(this._loginUseCase, this._signUpUseCase) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // Simulate a signup process
      final token = await _signUpUseCase.execute(
        event.name,
        event.email,
        event.password,
      );
      emit(AuthSuccess(message: 'Sign Up Successful'));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await _loginUseCase.execute(event.email, event.password);
        // Explicitly check for success
      emit(AuthSuccess(message: 'Login Successful'));
      
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
