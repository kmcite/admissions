import 'package:admissions/main.dart';
import 'package:admissions/state_tree.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class RegisterAction extends AppAction {
  RegisterAction();
  @override
  StateTree reduce() {
    return state;
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                context.dispatch(RegisterAction());
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
