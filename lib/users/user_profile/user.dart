import 'package:admissions/programs/programs.dart';
import 'package:manager/collection.dart';
import 'package:manager/manager.dart';

class User extends Model {
  @override
  String id = randomId;
  String name = "";
  String email = "";
  String password = "";
  String educations = "";
  String experiences = "";
  String phoneNumber = '';
  DateTime? dateOfBirth;
  String highSchool = '';
  double gpa = 0.0;

  /// Private field for storing applied program IDs as JSON
  String _programs = '';

  /// Getter to return list of applied programs
  List<Program> get programs {
    try {
      return (jsonDecode(_programs) as List).map(
        (json) {
          return Program.fromJson(json);
        },
      ).toList();
    } catch (_) {
      return [];
    }
  }

  /// Setter to update applied programs
  set programs(List<Program> ids) {
    _programs = jsonEncode(ids);
  }

  /// Apply to a program (stores program ID)
  void apply(Program program) {
    final updatedPrograms = programs..add(program);
    programs = updatedPrograms; // Prevent duplicates
  }

  /// Cancel application
  void cancel(Program program) {
    final updatedPrograms = programs.where((prog) => prog.id != program.id);
    programs = updatedPrograms.toList();
  }

  User();

  /// Deserialize from JSON
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? randomId;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    educations = json['educations'] ?? '';
    experiences = json['experiences'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    dateOfBirth = json['dateOfBirth'] != null
        ? DateTime.tryParse(json['dateOfBirth'])
        : null;
    highSchool = json['highSchool'] ?? '';
    gpa = (json['gpa'] ?? 0.0).toDouble();
    _programs = json['programs'] ?? '[]';
  }

  /// Serialize to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'educations': educations,
      'experiences': experiences,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'highSchool': highSchool,
      'gpa': gpa,
      'programs': _programs,
    };
  }
}
