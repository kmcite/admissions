import 'package:admissions/main.dart';
import 'package:admissions/state_tree.dart';

class DbAction extends AppAction {
  @override
  void after() {
    dispatch(RefreshPrograms());
    dispatch(RefreshUsers());
  }
}

class Put<T> extends DbAction {
  final T item;
  Put(this.item);
  @override
  StateTree reduce() {
    state.dependencies.store.box<T>().put(item);
    return state;
  }
}

class Remove<T> extends DbAction {
  final T item;
  Remove(this.item);
  @override
  StateTree reduce() {
    state.dependencies.store.box<T>().remove((item as dynamic).id);
    return state;
  }
}

class RemoveAll<T> extends DbAction {
  RemoveAll();
  @override
  StateTree reduce() {
    state.dependencies.store.box<T>().removeAll();
    return state;
  }
}
