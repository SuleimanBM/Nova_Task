import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate a signup process
    await Future.delayed(Duration(seconds: 2));
    emit(AuthSuccess(message: 'Sign Up Successful'));
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate a login process
    await Future.delayed(Duration(seconds: 2));
    emit(AuthSuccess(message: 'Login Successful'));
  }

}
