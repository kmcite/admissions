import '../main.dart';
import '../users/user_profile/user.dart';

final authenticationRepository = AuthenticationRepository();

class AuthenticationRepository {
  final authenticationRM = RM.inject(() => Authentication());

  Authentication get authentication => authenticationRM.state;

  String? get id => authentication._user?.id;

  void login(User? user) {
    authenticationRM.put(
      authentication.._user = user,
    );
  }

  void logout() {
    authenticationRM.put(authentication.._user = null);
  }
}

class Authentication {
  User? _user;
  bool get isLoggedIn => _user != null;
}
