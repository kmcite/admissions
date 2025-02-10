import 'package:admissions/main.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:manager/collection.dart';

class Program extends Model {
  @override
  String id = randomId;
  String name = '';
  String category = '';
  String description = '';
  bool editing = false;
  int fees = 2300;

  /// Private field for storing applicants as JSON
  String _applicants = '';

  /// Getter to return list of user IDs who applied
  List<String> get applicants {
    try {
      return List<String>.from(jsonDecode(_applicants));
    } catch (_) {
      return [];
    }
  }

  /// Setter to update applicant list
  set applicants(List<String> ids) {
    _applicants = jsonEncode(ids);
  }

  /// Add an applicant
  void addApplicant(User user) {
    final updatedApplicants = applicants..add(user.id);
    applicants = updatedApplicants.toSet().toList(); // Prevent duplicates
  }

  /// Remove an applicant
  void removeApplicant(User user) {
    final updatedApplicants = applicants..remove(user.id);
    applicants = updatedApplicants;
  }

  Program();

  /// Deserialize from JSON
  Program.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    category = json['category'] ?? '';
    description = json['description'] ?? '';
    editing = json['editing'] ?? false;
    fees = (json['fees'] ?? 2300).toInt();
    _applicants = json['applicants'] ?? '[]';
  }

  /// Serialize to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'editing': editing,
      'fees': fees,
      'applicants': _applicants,
    };
  }
}

class ProgramsRepository extends Collection<Program> {
  ProgramsRepository({required super.fromJson});
}

final programsRepository = ProgramsRepository(fromJson: Program.fromJson);

final programsRM = ProgramsBloc();

class ProgramsBloc {
  final programsRM = RM.injectStream(
    () => programsRepository.watch(),
    initialState: programsRepository.getAll(),
    autoDisposeWhenNotUsed: false,
  );
  Iterable<Program> get programs => programsRM.state;

  int count() => programs.length;

  void put(Program program) => programsRepository.put(program);
}
