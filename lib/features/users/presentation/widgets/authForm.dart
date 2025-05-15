import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final String action;
  final Function(String email, String password) onSubmit;

  const AuthForm({required this.action, required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: const ValueKey('email'),
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value != null && value.contains('@')
                  ? null
                  : 'Enter a valid email',
              onSaved: (value) => _email = value!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const ValueKey('password'),
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value != null && value.length >= 6
                  ? null
                  : 'Password must be at least 6 characters',
              onSaved: (value) => _password = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(widget.action),
            )
          ],
        ),
      ),
    );
  }
}
