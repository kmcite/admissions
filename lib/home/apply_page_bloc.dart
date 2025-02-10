import 'package:admissions/authentication/authentication_repository.dart';
import 'package:admissions/programs/programs.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:admissions/users/users_repository.dart';
import 'package:manager/manager.dart';

class ApplyPageBloc {
  Iterable<Program> get programs => userRM.state?.programs ?? [];
  bool isAlreadyApplied(Program checkingProgram) {
    return programs.where(
      (program) {
        return program.id == checkingProgram.id;
      },
    ).isNotEmpty;
  }

  final userRM = RM.inject<User?>(() => null);

  void load() =>
      userRM.state = usersRepository.get(authenticationRepository.id ?? '');

  void unload() => userRM.state = null;

  void apply(Program program) {
    final s = userRM.state!..apply(program);
    userRM
      ..state = s
      ..notify();
    usersRepository.put(s);
  }
}
