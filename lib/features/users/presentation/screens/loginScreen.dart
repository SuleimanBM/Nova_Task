import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_task/features/users/presentation/screens/signupScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_task/main.dart';
import '../bloc/authBloc.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';
import '../widgets/authForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context, String email, String password) {
    context.read<AuthBloc>().add(LoginRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MyHomePage()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              AuthForm(
                  action: 'Login',
                  onSubmit: (name, email, pass) => _handleLogin(context, email, pass)),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? " ,style: TextStyle(fontSize: 12.sp),),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      child: Text('Sign Up', style: TextStyle(fontSize: 12.sp),)
                      )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
