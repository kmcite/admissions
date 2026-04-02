import 'dart:async';

import 'package:admissions/authentication/authentication_screen.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/home/home_page.dart';
import 'package:admissions/state_tree.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final store = Store<StateTree>(
  initialState: StateTree(),
  actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NavigateAction.setNavigatorKey(navigatorKey);

  runApp(
    StoreProvider(
      store: store..dispatch(LoadDependenciesAction()),
      child: const AdmissionsApp(),
    ),
  );
}

class AdmissionsApp extends StatelessWidget {
  const AdmissionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigateAction.navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: yaruLight,
      darkTheme: yaruDark,
      home: context.isWaiting(LoadDependenciesAction)
          ? Center(child: YaruCircularProgressIndicator())
          : context.state.authentication.isLoggedIn
          ? HomePage()
          : AuthenticationScreen(),
    );
  }
}

abstract class AppAction extends ReduxAction<StateTree> {
  @override
  FutureOr<StateTree> reduce() async => state;
}

typedef Navigate = NavigateAction<StateTree>;
