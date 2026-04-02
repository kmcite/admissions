import 'package:admissions/db_actions.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/users/user_profile/user_actions.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class MyApplicationsPage extends StatelessWidget {
  const MyApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('My Applications'),
        suffixes: [
          FHeaderAction.back(
            onPress: () {
              dispatch(Navigate.pop());
            },
          ),
        ],
      ),
      child: context.state.authentication.user?.programs.isEmpty ?? true
          ? FLabel(axis: Axis.vertical, child: Text('No applications'))
          : FTileGroup.builder(
              count: context.state.authentication.user!.programs.length,
              tileBuilder: (context, index) {
                final application = context.state.authentication.user!.programs
                    .elementAt(index);
                return FTile(
                  prefix: Icon(FIcons.apple),
                  title: FTextField(
                    key: Key(application.id.toString()),
                    description: Text(application.name),
                    label: Text('application'),
                    control: .lifted(
                      value: TextEditingValue(text: application.name),
                      onChange: (value) {
                        dispatch(Put(application..name = value.text));
                      },
                    ),
                  ),
                  suffix: FButton.icon(
                    onPress: () {
                      context.state.authentication.user?.programs.remove(
                        application,
                      );
                      dispatch(
                        UserProgramsChanged(
                          context.state.authentication.user!.programs,
                        ),
                      );
                    },
                    child: Icon(FIcons.delete),
                  ),
                );
              },
            ),
    );
  }
}
