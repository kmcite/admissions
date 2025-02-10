// ignore_for_file: must_be_immutable

import 'package:admissions/authentication/authentication_bloc.dart';
import 'package:admissions/main.dart';
import 'package:admissions/navigation.dart';
import 'package:admissions/users/user_profile/user_profile_bloc.dart';
import 'package:forui/forui.dart';

import 'user.dart';

class UserProfilePage extends UI {
  late UserProfileBloc userProfileBloc;

  @override
  void didMountWidget(BuildContext context) {
    userProfileBloc = UserProfileBloc(authenticationBloc.user ?? User());
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Profile'),
        actions: [
          if (userProfileBloc.loading)
            FButton.icon(
              onPress: null,
              child: FButtonSpinner(),
            ),
          if (userProfileBloc.hasChanges)
            FButton.icon(
              style: FButtonStyle.primary,
              onPress: userProfileBloc.updateUser,
              child: FIcon(FAssets.icons.saveAll),
            ),
          if (userProfileBloc.noChanges)
            FButton.icon(
              onPress: null,
              child: FIcon(FAssets.icons.checkCheck),
            ),
          FButton.icon(
            child: FIcon(FAssets.icons.arrowLeft),
            onPress: navigator.pop,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Existing Fields
            FTextField(
              label: 'name'.text(),
              initialValue: userProfileBloc.user.name,
              onChange: userProfileBloc.changeName,
            ).pad(),
            FTextField(
              label: 'email'.text(),
              initialValue: userProfileBloc.user.email,
              onChange: userProfileBloc.changeEmail,
            ).pad(),
            FTextField(
              label: 'password'.text(),
              initialValue: userProfileBloc.user.password,
              onChange: userProfileBloc.changePassword,
            ).pad(),
            FTextField(
              label: 'educations'.text(),
              initialValue: userProfileBloc.user.educations,
              onChange: userProfileBloc.changeEducations,
              minLines: 5,
              maxLines: 8,
            ).pad(),
            FTextField(
              label: 'experiences'.text(),
              initialValue: userProfileBloc.user.experiences,
              onChange: userProfileBloc.changeExperiences,
              minLines: 5,
              maxLines: 8,
            ).pad(),

            // Admission Form Fields
            FTextField(
              label: 'phone_number'.text(),
              initialValue: userProfileBloc.user.phoneNumber,
              onChange: userProfileBloc.changePhoneNumber,
            ).pad(),
            FTile(
              onPress: () async {
                final selectedDate = await navigator.dateDialog(
                  initialDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  userProfileBloc.changeDateOfBirth(selectedDate);
                }
              },
              title: 'date of birth'.text(),
              subtitle: '${userProfileBloc.user.dateOfBirth}'.text(),
            ).pad(),
            FTextField(
              label: 'high school'.text(),
              initialValue: userProfileBloc.user.highSchool,
              onChange: userProfileBloc.changeHighSchool,
            ).pad(),
            FTextField(
              label: 'gpa'.text(),
              initialValue: userProfileBloc.user.gpa.toString(),
              onChange: (value) =>
                  userProfileBloc.changeGpa(double.tryParse(value) ?? 0.0),
            ).pad(),
            FTileGroup.builder(
              label: 'applied programs'.text(),
              count: userProfileBloc.user.programs.length,
              tileBuilder: (context, index) {
                final program = userProfileBloc.user.programs.elementAt(index);
                return FTile(
                  suffixIcon: userProfileBloc.user.programs.contains(program)
                      ? FButton.icon(
                          onPress: () {
                            userProfileBloc.user = userProfileBloc.user
                              ..apply(program);
                          },
                          child: FIcon(FAssets.icons.equalApproximately),
                        )
                      : FButton.icon(
                          onPress: () {
                            userProfileBloc.user = userProfileBloc.user
                              ..cancel(program);
                          },
                          child: FIcon(FAssets.icons.delete),
                        ),
                  title: program.name.text(),
                  // onPress: () {
                  // },
                );
              },
              description:
                  '${userProfileBloc.user.programs.isEmpty ? 'No programs applied for' : ''}  '
                      .text(),
            ).pad(),
          ],
        ),
      ),
    );
  }

  void dispose() {
    userProfileBloc.dispose();
  }
}
