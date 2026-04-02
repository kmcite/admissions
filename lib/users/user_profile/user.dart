import 'package:admissions/programs/programs.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  String name = "";
  String email = "";
  String password = "";
  String educations = "";
  String experiences = "";
  String phoneNumber = '';
  DateTime? dateOfBirth;
  String highSchool = '';
  double gpa = 0.0;
  final programs = ToMany<Program>();

  void apply(Program program) {
    programs.add(program);
  }

  void cancel(Program program) {
    programs.remove(program);
  }
}
