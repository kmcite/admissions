import 'dart:async';

import 'package:admissions/authentication/authentication.dart';
import 'package:admissions/main.dart';
import 'package:admissions/objectbox.g.dart';
import 'package:admissions/programs/programs.dart';
import 'package:admissions/users/user_profile/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateTree {
  Authentication authentication = Authentication();
  bool dark = false;

  ///
  List<Program> programs = [];
  List<User> applicants = [];

  ///

  ///
  late Dependencies dependencies;
}

class Dependencies {
  final Store store;
  final SharedPreferences sharedPreferences;
  const Dependencies(this.store, this.sharedPreferences);
}

class LoadDependenciesAction extends AppAction {
  @override
  Future<StateTree> reduce() async {
    final path = await getApplicationDocumentsDirectory();
    final sharedPreferences = await SharedPreferences.getInstance();
    final store = await openStore(
      directory: join(path.path, "admissions"),
    );
    await Future.delayed(Duration(seconds: 1));
    state.dependencies = Dependencies(
      store,
      sharedPreferences,
    );
    return state;
  }
}

class RefreshPrograms extends AppAction {
  @override
  StateTree reduce() {
    state.programs = state.dependencies.store.box<Program>().getAll();
    return state;
  }
}

class RefreshUsers extends AppAction {
  @override
  StateTree reduce() {
    state.applicants = state.dependencies.store.box<User>().getAll();
    return state;
  }
}
