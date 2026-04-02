import 'package:admissions/db_actions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/programs/programs.dart';
import 'package:admissions/state_tree.dart';

abstract class UserProfileAction extends AppAction {
  @override
  void after() {
    dispatch(Put(state.authentication.user!));
  }
}

class UserNameChanged extends UserProfileAction {
  final String name;
  UserNameChanged(this.name);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..name = name;
    return state..authentication.user = user;
  }
}

class UserEmailChanged extends UserProfileAction {
  final String email;
  UserEmailChanged(this.email);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..email = email;
    return state..authentication.user = user;
  }
}

class UserPasswordChanged extends UserProfileAction {
  final String password;
  UserPasswordChanged(this.password);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..password = password;
    return state..authentication.user = user;
  }
}

class UserEducationsChanged extends UserProfileAction {
  final String educations;
  UserEducationsChanged(this.educations);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..educations = educations;
    return state..authentication.user = user;
  }
}

class UserExperiencesChanged extends UserProfileAction {
  final String experiences;
  UserExperiencesChanged(this.experiences);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..experiences = experiences;
    return state..authentication.user = user;
  }
}

class UserPhoneNumberChanged extends UserProfileAction {
  final String phoneNumber;
  UserPhoneNumberChanged(this.phoneNumber);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..phoneNumber = phoneNumber;
    return state..authentication.user = user;
  }
}

class UserDateOfBirthChanged extends UserProfileAction {
  final DateTime dateOfBirth;
  UserDateOfBirthChanged(this.dateOfBirth);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..dateOfBirth = dateOfBirth;
    return state..authentication.user = user;
  }
}

class UserHighSchoolChanged extends UserProfileAction {
  final String highSchool;
  UserHighSchoolChanged(this.highSchool);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..highSchool = highSchool;
    return state..authentication.user = user;
  }
}

class UserGpaChanged extends UserProfileAction {
  final double gpa;
  UserGpaChanged(this.gpa);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..gpa = gpa;
    return state..authentication.user = user;
  }
}

class UserProgramsChanged extends UserProfileAction {
  final List<Program> programs;
  UserProgramsChanged(this.programs);
  @override
  StateTree reduce() {
    final user = state.authentication.user?..programs.addAll(programs);
    return state..authentication.user = user;
  }
}
