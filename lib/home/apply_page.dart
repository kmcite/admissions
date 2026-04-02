import 'dart:async';

import 'package:admissions/db_actions.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/programs/programs.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

// final applyPageBloc = ApplyPageBloc();

// class LoadApplyPageAction extends AppAction {
//   @override
//   FutureOr<StateTree> reduce() async {
//     return state..application = Program();
//   }
// }

class ApplyPage extends StatelessWidget {
  // void didMountWidget(BuildContext context) {
  //   applyPageBloc.load();
  // }

  // void didUnmountWidget() {
  //   applyPageBloc.unload();
  // }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text("Apply Page"),
        suffixes: [
          FHeaderAction.back(
            onPress: () => dispatch(Navigate.pop()),
          ),
        ],
      ),
      child: Column(
        children: [
          FTileGroup(
            children: context.state.programs.map(
              (program) {
                return FTile(
                  title: Text(program.name),
                  subtitle: FButton(
                    onPress:
                        context.state.authentication.isAlreadyApplied(program)
                        ? null
                        : () {
                            context.dispatch(ApplyAction(program));
                          },
                    child: Text('Apply'),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

class ApplyAction extends AppAction {
  final Program program;
  ApplyAction(this.program);
  @override
  FutureOr<void> after() {
    final user = state.authentication.user;
    dispatch(Put(user?..programs.add(program)));
  }
}
