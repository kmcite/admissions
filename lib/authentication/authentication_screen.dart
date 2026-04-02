import 'package:admissions/authentication/authentication.dart';
import 'package:admissions/authentication/registeration_screen.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            TextFormField(
              initialValue: context.state.authentication.loginForm.email,
              onChanged: (value) {
                context.dispatch(EmailUpdateAction(email: value));
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              initialValue: context.state.authentication.loginForm.password,
              onChanged: (value) {
                context.dispatch(PasswordUpdateAction(password: value));
              },
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed:
                  context.state.authentication.loginForm.isLoginValid &&
                      !context.isWaiting(LoginAction)
                  ? () {
                      dispatch(LoginAction(user: User()));
                    }
                  : null,
              child: context.isWaiting(LoginAction)
                  ? CircularProgressIndicator()
                  : Text("Login"),
            ),
            TextButton(
              onPressed: () {
                dispatch(
                  Navigate.push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  ),
                );
              },
              child: const Text("Not registered? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
