import 'package:admissions/authentication/authentication_bloc.dart';
import 'package:forui/forui.dart';

import '../main.dart';

class AuthenticationPage extends UI {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader(title: Text('Login')),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTextField(
              label: const Text('Email'),
              controller: authenticationBloc.loginEmailRM,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTextField.password(
              label: const Text('Password'),
              obscureText: authenticationBloc.obscure,
              controller: authenticationBloc.loginPasswordRM,
              description: FButton.icon(
                child: FIcon(
                  authenticationBloc.obscure
                      ? FAssets.icons.eyeOff
                      : FAssets.icons.eye,
                ),
                onPress: authenticationBloc.toggleObscure,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FButton(
              onPress: authenticationBloc.login,
              label: const Text("Login"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FButton(
              onPress: authenticationBloc.register,
              label: const Text("Register"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FButton(
              onPress: authenticationBloc.forgotPassword,
              label: const Text("Forgot Password?"),
            ),
          ),
          if (authenticationBloc.hasError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                authenticationBloc.errorMessage,
              ),
            ),
        ],
      ),
    );
  }
}
