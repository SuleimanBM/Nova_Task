import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authBloc.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';
import '../widgets/authForm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _handleSignUp(BuildContext context, String email, String password) {
    context.read<AuthBloc>().add(SignUpRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return AuthForm(
              action: 'Sign Up',
              onSubmit: (email, pass) => _handleSignUp(context, email, pass));
        },
      ),
    );
  }
}
