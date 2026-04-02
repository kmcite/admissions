import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class OtherApplicants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Applicants'),
        suffixes: [
          FHeaderAction.back(
            onPress: () => dispatch(Navigate.pop()),
          ),
        ],
      ),
      child: Column(
        children: [
          FTileGroup.builder(
            count: context.state.applicants.length,
            tileBuilder: (context, index) {
              final user = context.state.applicants[index];
              return FTile(
                title: Text(
                  '${user.name} ${user == context.state.authentication.user ? '(You)' : '${user.id}'} ',
                ),
                // onPress: () {},
                suffix: user == context.state.authentication.user
                    ? Icon(FIcons.check, color: Colors.green)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
