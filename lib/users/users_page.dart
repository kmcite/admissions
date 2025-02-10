import 'package:admissions/authentication/authentication_bloc.dart';
import 'package:admissions/main.dart';
import 'package:admissions/navigation.dart';
import 'package:admissions/users/users_bloc.dart';
import 'package:forui/forui.dart';

class UsersPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'Applicants'.text(),
        actions: [
          FHeaderAction.back(onPress: navigator.pop),
        ],
      ),
      content: Column(
        children: [
          FTileGroup.builder(
            count: usersRM.count(),
            tileBuilder: (context, index) {
              final user = usersRM.getAll().elementAt(index);
              return FTile(
                title:
                    '${user.name} ${user == authenticationBloc.user ? '(You)' : ''} '
                        .text(),
                // onPress: () {},
                suffixIcon: user == authenticationBloc.user
                    ? FIcon(FAssets.icons.check, color: Colors.green)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
