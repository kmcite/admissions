import 'package:admissions/users/user_profile/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Program {
  @Id()
  int id = 0;
  String name = '';
  String category = '';
  String description = '';
  bool editing = false;
  int fees = 2300;

  final applicants = ToMany<User>();

  /// Add an applicant
  void addApplicant(User user) {
    applicants.add(user);
  }

  /// Remove an applicant
  void removeApplicant(User user) {
    applicants.remove(user);
  }
}
