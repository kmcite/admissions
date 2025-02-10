// ignore_for_file: must_be_immutable

import 'package:admissions/main.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:admissions/users/users_repository.dart';

enum UserProfileStatus {
  loading,
  hasChanges,
  noChanges,
}

class UserProfileBloc {
  final User _user;
  late final userRM = RM.inject(() => _user);
  UserProfileBloc(this._user);

  User get user => userRM.state;
  set user(User state) => userRM
    ..state = state
    ..notify();

  final statusRM = RM.inject(() => UserProfileStatus.noChanges);

  UserProfileStatus get status => statusRM.state;
  set status(UserProfileStatus value) {
    statusRM.state = value;
  }

  // Existing Methods
  changeName(String name) {
    user = user..name = name;
    status = UserProfileStatus.hasChanges;
  }

  changeEmail(String email) {
    user = user..email = email;
    status = UserProfileStatus.hasChanges;
  }

  changePassword(String password) {
    user = user..password = password;
    status = UserProfileStatus.hasChanges;
  }

  changeEducations(String educations) {
    user = user..educations = educations;
    status = UserProfileStatus.hasChanges;
  }

  changeExperiences(String experiences) {
    user = user..experiences = experiences;
    status = UserProfileStatus.hasChanges;
  }

  // Admission Form Methods
  changePhoneNumber(String phoneNumber) {
    user = user..phoneNumber = phoneNumber;
    status = UserProfileStatus.hasChanges;
  }

  changeDateOfBirth(DateTime dateOfBirth) {
    user = user..dateOfBirth = dateOfBirth;
    status = UserProfileStatus.hasChanges;
  }

  changeHighSchool(String highSchool) {
    user = user..highSchool = highSchool;
    status = UserProfileStatus.hasChanges;
  }

  changeGpa(double gpa) {
    user = user..gpa = gpa;
    status = UserProfileStatus.hasChanges;
  }

  bool get hasChanges => status == UserProfileStatus.hasChanges;
  bool get loading => status == UserProfileStatus.loading;
  bool get noChanges => status == UserProfileStatus.noChanges;

  void updateUser() async {
    status = UserProfileStatus.loading;
    usersRepository.put(user);
    await Future.delayed(const Duration(seconds: 1));
    status = UserProfileStatus.noChanges;
  }

  void dispose() {
    userRM.state = _user;
  }
}
