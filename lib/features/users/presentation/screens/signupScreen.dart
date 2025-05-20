import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_task/features/tasks/taskHomePage.dart';
import 'package:nova_task/features/users/presentation/screens/loginScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/authBloc.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';
import '../widgets/authForm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _handleSignUp(
      BuildContext context, String name, String email, String password) {
    context.read<AuthBloc>().add(SignUpRequested(name, email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message, style: TextStyle(fontSize: 16.sp))));

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MyHomePage()));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(children: [
            AuthForm(
                action: 'Sign Up',
                onSubmit: (name, email, pass) =>
                    _handleSignUp(context, name, email, pass)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ", style: TextStyle(fontSize: 12.sp),),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text('Login', style: TextStyle(fontSize: 12.sp)))
              ],
            )
          ]);
        },
      ),
    );
  }
}
