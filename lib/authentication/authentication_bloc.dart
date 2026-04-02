// import 'package:admissions/authentication/authentication.dart';
// import 'package:admissions/navigation.dart';
// import 'package:admissions/users/user_profile/user.dart';
// import 'package:admissions/users/users_repository.dart';
// import 'package:flutter/material.dart';

// import 'authentication_repository.dart';

// // Assuming these repositories exist
// final authenticationBloc = AuthenticationBloc();

// class AuthenticationBloc {
//   Authentication get authentication => authenticationRepository.authentication;
//   User? get user {
//     // return usersRepository.get(authenticationRepository.id ?? '')
//     return null;
//   }

//   String _errorMessage = '';
//   String get errorMessage => _errorMessage;

//   bool get isAuthenticated => user != null;
//   bool get hasError => _errorMessage.isNotEmpty;

//   final loginEmailRM = TextEditingController(text: 'adn@gmail.com');
//   final loginPasswordRM = TextEditingController(text: 'asdf');

//   bool obscure = false;
//   void toggleObscure() {
//     obscure = !obscure;
//   }

//   void login() {
//     final email = loginEmailRM.text;
//     final password = (loginPasswordRM.text);

//     final user = usersRepository.authenticatedUser(email, password);

//     if (user == null) {
//       _errorMessage = "Invalid email or password.";
//       return;
//     }

//     authenticationRepository.login(user);
//     _errorMessage = ''; // Reset error on success
//     navigator.authenticationChanged(authentication);
//   }

//   // Logout Process
//   void logout() {
//     authenticationRepository.logout();
//     navigator.authenticationChanged(authentication);
//   }

//   // Register with Email Duplication Check
//   void register() {
//     final email = loginEmailRM.text;
//     final password = (loginPasswordRM.text);

//     if (usersRepository.exists(email)) {
//       _errorMessage = "Email is already registered.";
//       return;
//     }

//     // final user = User()
//     //   ..email = email
//     //   ..password = password; // Default role

//     // usersRepository.put(user);
//     login(); // Auto-login after registration
//   }

//   // Forgot Password - Simulating a reset process
//   void forgotPassword() {
//     final email = loginEmailRM.text;
//     final user = usersRepository.findByEmail(email);

//     if (user == null) {
//       _errorMessage = "Email not found.";
//       return;
//     }

//     // In a real app, send a password reset link or code
//     _errorMessage = "Password reset instructions sent.";
//   }

//   void dispose() {
//     loginEmailRM.dispose();
//     loginPasswordRM.dispose();
//   }
// }
