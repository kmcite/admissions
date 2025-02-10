import 'package:admissions/authentication/authentication_repository.dart';
import 'package:admissions/programs/programs.dart';
import 'package:admissions/users/users_repository.dart';

final appliedProgramsRM = AppliedProgramsBloc();

class AppliedProgramsBloc {
  Iterable<Program> get appliedPrograms {
    if (authenticationRepository.id != null) {
      final user = usersRepository.get(authenticationRepository.id!);
      if (user != null) {
        return user.programs;
      }
      return [];
    } else
      return [];
  }

  void cancel(Program application) {
    usersRepository.get(authenticationRepository.id ?? '')?.cancel(application);
  }
}
