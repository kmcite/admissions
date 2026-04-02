import 'package:admissions/db_actions.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/programs/programs.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ProgramsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('PROGRAMS'),
        suffixes: [
          FHeaderAction.back(
            onPress: () {
              dispatch(Navigate.pop());
            },
          ),
        ],
      ),
      child: context.state.programs.isEmpty
          ? FLabel(
              axis: Axis.vertical,
              child: Text('No programs yet'),
            )
          : FTileGroup.builder(
              count: context.state.programs.length,
              tileBuilder: (context, index) {
                final program = context.state.programs.elementAt(index);
                return FTile(
                  title: program.editing
                      ? FTextFormField(
                          control: .lifted(
                            value: TextEditingValue(text: program.name),
                            onChange: (value) {
                              context.dispatch(Put(program..name = value.text));
                            },
                          ),
                        )
                      : Text(program.name),
                  subtitle: program.editing
                      ? FTextFormField(
                          control: .lifted(
                            value: TextEditingValue(text: program.description),
                            onChange: (tev) {
                              context.dispatch(
                                Put(program..description = tev.text),
                              );
                            },
                          ),
                        )
                      : Text(program.description),
                  details: Text(program.fees.toString()),
                  prefix: FCheckbox(
                    value: program.editing,
                    onChange: (value) {
                      context.dispatch(Put(program..editing = value));
                    },
                  ),
                );
              },
            ),
      footer: FButton(
        onPress: () {
          context.dispatch(Put(Program()));
        },
        child: Text('Create a program'),
      ),
    );
  }
}
