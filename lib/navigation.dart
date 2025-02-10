import 'package:admissions/authentication/authentication_repository.dart';
import 'package:admissions/home/home_page.dart';
import 'package:admissions/main.dart';
import 'package:forui/forui.dart';

import 'authentication/login_page.dart';

final navigator = Navigation();

/// is a bloc/repository
class Navigation {
  final key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentContext!;
  NavigatorState get state => key.currentState!;

  void authenticationChanged(Authentication authentication) {
    if (authentication.isLoggedIn) {
      pushAndRemoveUntilWidget(HomePage());
    } else {
      pushAndRemoveUntilWidget(AuthenticationPage());
    }
  }

  Future<T?> pushNamed<T extends Object?>(String routeName) {
    return state.pushNamed(routeName);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(String routeName) {
    return state.pushReplacementNamed(routeName);
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String routeName) {
    return state.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<T?> pushNamedAndRemoveAll<T extends Object?>(String routeName) {
    return state.pushNamedAndRemoveUntil(routeName, (route) => true);
  }

  Future<T?> push<T extends Object?>(Route<T> route) => state.push(route);

  Future<T?> pushReplacement<T extends Object?>(Route<T> route) =>
      state.pushReplacement(route);

  Future<T?> pushAndRemoveUntil<T extends Object?>(Route<T> route) =>
      state.pushAndRemoveUntil(route, (route) => false);

  Future<T?> pushAndRemoveAll<T extends Object?>(Route<T> route) =>
      state.pushAndRemoveUntil(route, (route) => true);

  Future<T?> pushWidget<T extends Object?>(Widget widget) => state.push(
        MaterialPageRoute(builder: (context) => widget),
      );

  Future<T?> pushReplacementWidget<T extends Object?>(Widget widget) =>
      state.pushReplacement(MaterialPageRoute(builder: (context) => widget));

  Future<T?> pushAndRemoveUntilWidget<T extends Object?>(Widget widget) =>
      state.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (route) => false,
      );

  Future<T?> pushAndRemoveAllWidget<T extends Object?>(Widget widget) =>
      state.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (route) => true,
      );

  void pop<T extends Object?>([T? result]) => state.pop(result);
  Future<T?> dateDialog<T>({
    DateTime? initialDate,
    bool Function(DateTime)? selectable,
  }) {
    final controller = FCalendarController.date(
      initialSelection: initialDate,
      selectable: selectable,
    );
    return showDialog(
      context: context,
      builder: (context) {
        return FScaffold(
          header: FHeader(
            title: 'Date Selector'.text(),
            actions: [
              FHeaderAction.back(onPress: navigator.pop),
            ],
          ),
          content: Center(
            child: FCalendar(
              controller: controller,
              onPress: (value) {
                navigator.pop(value);
              },
            ),
          ),
        );
      },
    );
  }
}
