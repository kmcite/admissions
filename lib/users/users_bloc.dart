import 'package:admissions/users/user_profile/user.dart';
import 'package:admissions/users/users_repository.dart';

class UsersBloc {
  int count() => usersRepository.getAll().length;
  Iterable<User> getAll() => usersRepository.getAll();
}

final usersRM = UsersBloc();
