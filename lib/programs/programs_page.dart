import 'package:admissions/main.dart';
import 'package:admissions/navigation.dart';
import 'package:admissions/programs/programs.dart';
import 'package:forui/forui.dart';

class ProgramsPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'PROGRAMS'.text(),
        actions: [
          FHeaderAction.back(onPress: navigator.pop),
        ],
      ),
      content: programsRM.programs.isEmpty
          ? FLabel(
              axis: Axis.vertical,
              child: 'No programs yet'.text(),
            )
          : FTileGroup.builder(
              count: programsRM.count(),
              tileBuilder: (context, index) {
                final program = programsRM.programs.elementAt(index);
                return FTile(
                  title: program.editing
                      ? FTextField(
                          initialValue: program.name,
                          onChange: (value) {
                            programsRM.put(program..name = value);
                          },
                        )
                      : program.name.text(),
                  subtitle: program.editing
                      ? FTextField(
                          initialValue: program.description,
                          onChange: (value) {
                            programsRM.put(program..description = value);
                          },
                        )
                      : program.description.text(),
                  details: program.fees.text(),
                  prefixIcon: FCheckbox(
                    value: program.editing,
                    onChange: (value) =>
                        programsRM.put(program..editing = value),
                  ),
                );
              },
            ),
      footer: FButton(
        onPress: () {
          programsRM.put(Program());
        },
        label: 'Create a program'.text(),
      ).pad(),
    );
  }
}
