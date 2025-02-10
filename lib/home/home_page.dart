import 'package:admissions/authentication/authentication_bloc.dart';
import 'package:admissions/home/apply_page.dart';
import 'package:admissions/main.dart';
import 'package:admissions/navigation.dart';
import 'package:admissions/users/users_page.dart';
import 'package:forui/forui.dart';
import '../applications/my_applications_page.dart';
import '../programs/programs_page.dart';
import '../users/user_profile/user_profile_page.dart';

// 📌 AppBar (Header)
// Keep the title and action buttons, but add a profile picture instead of a generic icon.
// Display user name & email for personalization.
// 📌 Dashboard Sections
// 👉 (A) Quick Actions (Two Large Buttons)

// "Apply Now" (Primary CTA – Make it stand out in color and size)
// "My Applications" (Quick access to submitted applications)
// 👉 (B) Information Cards (Two-Column Layout)

// Latest News (Scrollable list inside a card)
// Upcoming Events (Show deadlines in a list format with icons)
// 👉 (C) Featured & Social (Two-Column Layout)

// Featured Programs (Carousel of top programs)
// Other Students (Display a grid of avatars with names)

class HomePage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Admissions'),
        actions: [
          FButton.icon(
            onPress: () {
              navigator.pushWidget(UserProfilePage());
            },
            child: FIcon(FAssets.icons.user),
          ),
          FButton.icon(
            child: FIcon(FAssets.icons.logOut),
            onPress: () => authenticationBloc.logout(),
          )
        ],
      ),
      content: Column(
        children: [
          FBadge(
            label: (authenticationBloc.user?.name).text(),
          ).pad(),
          FBadge(
            label: (authenticationBloc.user?.email).text(),
          ).pad(),
          FButton(
            prefix: FIcon(FAssets.icons.panelRightOpen),
            label: Text('APPLY NOW'),
            onPress: () => navigator.pushWidget(ApplyPage()),
          ).pad(),
          FButton(
            prefix: FIcon(FAssets.icons.appWindowMac),
            label: Text("MY APPLICATIONS"),
            onPress: () => navigator.pushWidget(
              MyApplicationsPage(),
            ),
          ).pad(),
          FButton(
            prefix: FIcon(FAssets.icons.asterisk),
            label: Text('PROGRAMS AND COURSES'),
            onPress: () => navigator.pushWidget(ProgramsPage()),
          ).pad(),
          FButton(
            prefix: FIcon(FAssets.icons.pointer),
            label: Text('OTHER APPLICANTS'),
            onPress: () => navigator.pushWidget(UsersPage()),
          ).pad(),
        ],
      ),
    );
  }
}
