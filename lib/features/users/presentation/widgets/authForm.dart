import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthForm extends StatefulWidget {
  final String action;
  final Function(String name, String email, String password) onSubmit;

  const AuthForm({required this.action, required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(_name, _email, _password);
    }
  }

  bool get isSignUp => widget.action.toLowerCase() == 'sign up';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (isSignUp)
              TextFormField(
                key: const ValueKey('name'),
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(fontSize: 16.sp)),
                validator: (value) => value != null && value.trim().isNotEmpty
                    ? null
                    : 'Enter your name',
                onSaved: (value) => _name = value!.trim(),
              ),
            if (isSignUp) 12.verticalSpace,
            //const SizedBox(height: 12),

            TextFormField(
              key: const ValueKey('email'),
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 16.sp)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value != null && value.contains('@')
                  ? null
                  : 'Enter a valid email',
              onSaved: (value) => _email = value!,
            ),
            const SizedBox(height: 12),
            12.verticalSpace,
            TextFormField(
              key: const ValueKey('password'),
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(fontSize: 16.sp)),
              obscureText: true,
              validator: (value) => value != null && value.length >= 6
                  ? null
                  : 'Password must be at least 6 characters',
              onSaved: (value) => _password = value!,
            ),
            //const SizedBox(height: 20),
            20.verticalSpace,
            ElevatedButton(
              onPressed: _submit,
              child: Text(widget.action, style: TextStyle(fontSize: 16.sp),),
            ),
          ],
        ),
      ),
    );
  }
}
