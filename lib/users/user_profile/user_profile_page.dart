// ignore_for_file: must_be_immutable

import 'package:admissions/extensions.dart';
import 'package:admissions/main.dart';
import 'package:admissions/users/user_profile/user_actions.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Profile'),
        suffixes: [
          if (context.isWaiting(UserProfileAction))
            FButton.icon(
              onPress: null,
              child: FCircularProgress.loader(),
            ),
          FButton.icon(
            // style: FButtonStyle.primary,
            onPress: () {},
            child: Icon(FIcons.saveAll),
          ),
          FButton.icon(
            onPress: null,
            child: Icon(FIcons.checkCheck),
          ),
          FButton.icon(
            child: Icon(FIcons.arrowLeft),
            onPress: () => dispatch(Navigate.pop()),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Existing Fields
            FTextField(
              control: .managed(
                initial: TextEditingValue(
                  text: state.authentication.user?.name ?? '',
                ),
                onChange: (value) => dispatch(UserNameChanged(value.text)),
              ),
              label: Text('name'),
            ),
            FTextFormField(
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.email ?? '',
                ),
                onChange: (value) => dispatch(UserEmailChanged(value.text)),
              ),
              label: Text('email'),
            ),
            FTextFormField(
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.password ?? '',
                ),
                onChange: (value) => dispatch(UserPasswordChanged(value.text)),
              ),
              label: Text('password'),
            ),
            FTextFormField(
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.educations ?? '',
                ),
                onChange: (value) =>
                    dispatch(UserEducationsChanged(value.text)),
              ),
              label: Text('educations'),
              minLines: 5,
              maxLines: 8,
            ),
            FTextFormField(
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.experiences ?? '',
                ),
                onChange: (value) =>
                    dispatch(UserExperiencesChanged(value.text)),
              ),
              label: Text('experiences'),
              minLines: 5,
              maxLines: 8,
            ),

            // Admission Form Fields
            FTextFormField(
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.phoneNumber ?? '',
                ),
                onChange: (value) =>
                    dispatch(UserPhoneNumberChanged(value.text)),
              ),
              label: Text('phone_number'),
            ),
            FTile(
              onPress: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  dispatch(UserDateOfBirthChanged(selectedDate));
                }
              },
              title: Text('date of birth'),
              subtitle: Text(
                '${state.authentication.user?.dateOfBirth}',
              ),
            ),
            FTextFormField(
              label: Text('high school'),
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.highSchool ?? '',
                ),
                onChange: (value) =>
                    dispatch(UserHighSchoolChanged(value.text)),
              ),
            ),
            FTextFormField(
              label: Text('gpa'),
              control: .lifted(
                value: TextEditingValue(
                  text: state.authentication.user?.gpa.toString() ?? '0.0',
                ),
                onChange: (tev) {
                  dispatch(UserGpaChanged(double.tryParse(tev.text) ?? 0.0));
                },
              ),
            ),
            FTileGroup.builder(
              label: Text('applied programs'),
              count: state.authentication.user?.programs.length,
              tileBuilder: (context, index) {
                final program = state.authentication.user?.programs.elementAt(
                  index,
                );
                return FTile(
                  suffix:
                      state.authentication.user!.programs.contains(
                        program,
                      )
                      ? FButton.icon(
                          onPress: () {
                            dispatch(
                              UserProgramsChanged(
                                state.authentication.user!.programs
                                  ..remove(program),
                              ),
                            );
                          },
                          child: Icon(FIcons.equalApproximately),
                        )
                      : FButton.icon(
                          onPress: () {
                            dispatch(
                              UserProgramsChanged(
                                state.authentication.user!.programs
                                  ..remove(program),
                              ),
                            );
                          },
                          child: Icon(FIcons.delete),
                        ),
                  title: Text(program!.name),
                );
              },
              description: Text(
                '${state.authentication.user!.programs.isEmpty ? 'No programs applied for' : ''}  ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
