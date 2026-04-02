import 'package:admissions/authentication/authentication.dart';
import 'package:admissions/extensions.dart';
import 'package:admissions/home/apply_page.dart';
import 'package:admissions/main.dart';
import 'package:admissions/users/other_applicants.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../applications/my_applications_page.dart';
import '../programs/programs_page.dart';
import '../users/user_profile/user_profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Admissions'),
        suffixes: [
          FButton.icon(
            onPress: () {
              dispatch(
                Navigate.push(
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(),
                  ),
                ),
              );
            },
            child: Icon(FIcons.user),
          ),
          FButton.icon(
            child: Icon(FIcons.logOut),
            onPress: () {
              dispatch(LogoutAction());
            },
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        children: [
          FBadge(
            child: Text(context.state.authentication.user?.name ?? ''),
          ),
          FBadge(
            child: Text(context.state.authentication.user?.email ?? ''),
          ),
          FButton(
            prefix: Icon(FIcons.panelRightOpen),
            child: Text('APPLY NOW'),
            onPress: () => dispatch(
              Navigate.push(
                MaterialPageRoute(
                  builder: (context) => ApplyPage(),
                ),
              ),
            ),
          ),
          FButton(
            prefix: Icon(FIcons.appWindowMac),
            child: Text("MY APPLICATIONS"),
            onPress: () => dispatch(
              Navigate.push(
                MaterialPageRoute(
                  builder: (context) => MyApplicationsPage(),
                ),
              ),
            ),
          ),
          FButton(
            prefix: Icon(FIcons.asterisk),
            child: Text('PROGRAMS AND COURSES'),
            onPress: () => dispatch(
              Navigate.push(
                MaterialPageRoute(
                  builder: (context) => ProgramsPage(),
                ),
              ),
            ),
          ),
          FButton(
            prefix: Icon(FIcons.pointer),
            child: Text('OTHER APPLICANTS'),
            onPress: () => dispatch(
              Navigate.push(
                MaterialPageRoute(
                  builder: (context) => OtherApplicants(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
