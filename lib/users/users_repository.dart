import 'package:manager/collection.dart';

import 'user_profile/user.dart';

final usersRepository = UsersRepository(
  fromJson: User.fromJson,
);

class UsersRepository extends Collection<User> {
  UsersRepository({required super.fromJson});

  User? authenticatedUser(String email, String password) {
    return getAll().where(
      (user) {
        return user.email == email;
      },
    ).where(
      (user) {
        return user.password == password;
      },
    ).firstOrNull;
  }

  User? findByEmail(String email) =>
      getAll().where((user) => user.email == email).firstOrNull;

  bool exists(String email) => getAll().any((user) => user.email == email);
}
