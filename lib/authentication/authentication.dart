import 'package:admissions/main.dart';
import 'package:admissions/programs/programs.dart';
import 'package:admissions/state_tree.dart';
import 'package:admissions/users/user_profile/user.dart';

class Authentication {
  User? user;
  bool get isLoggedIn => user != null;

  /// logging in form
  LoginForm loginForm = LoginForm();

  bool isAlreadyApplied(Program program) {
    return user?.programs.contains(program) ?? false;
  }
}

class LoginForm {
  String email = 'adn@gmail.com';
  String password = '123456';

  bool get isEmailValid {
    return email.isNotEmpty && email.contains('@');
  }

  bool get isPasswordValid {
    return password.isNotEmpty && password.length >= 4;
  }

  bool get isLoginValid => isEmailValid && isPasswordValid;
}

class LoginAction extends AppAction {
  final User user;
  LoginAction({required this.user});
  @override
  Future<StateTree> reduce() async {
    final login = state.authentication.loginForm;
    final email = login.email;
    final password = login.password;
    await Future.delayed(Duration(seconds: 1));
    final user = (await state.dependencies.store.box<User>().getAllAsync())
        .where(
          (user) => user.email == email && user.password == password,
        )
        .firstOrNull;
    if (user != null) {
      final auth = state.authentication..user = user;
      return state..authentication = auth;
    } else {
      final auth = state.authentication..user = null;
      return state..authentication = auth;
    }
  }
}

class LogoutAction extends AppAction {
  @override
  StateTree reduce() {
    final auth = state.authentication..user = null;
    return state..authentication = auth;
  }
}

class EmailUpdateAction extends AppAction {
  final String email;
  EmailUpdateAction({required this.email});
  @override
  StateTree reduce() {
    final login = state.authentication.loginForm..email = email;
    final auth = state.authentication..loginForm = login;
    return state..authentication = auth;
  }
}

class PasswordUpdateAction extends AppAction {
  final String password;
  PasswordUpdateAction({required this.password});
  @override
  StateTree reduce() {
    final login = state.authentication.loginForm..password = password;
    final auth = state.authentication..loginForm = login;
    return state..authentication = auth;
  }
}
