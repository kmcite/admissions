import 'package:admissions/applications/my_applications_bloc.dart';
import 'package:admissions/main.dart';
import 'package:admissions/navigation.dart';
import 'package:forui/forui.dart';

class MyApplicationsPage extends UI {
  const MyApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('My Applications'),
        actions: [
          FHeaderAction.back(
            onPress: () => navigator.pop(),
          )
        ],
      ),
      content: appliedProgramsRM.appliedPrograms.isEmpty
          ? FLabel(axis: Axis.vertical, child: 'No applications'.text())
          : FTileGroup.builder(
              count: appliedProgramsRM.appliedPrograms.length,
              tileBuilder: (context, index) {
                final application =
                    appliedProgramsRM.appliedPrograms.elementAt(index);
                return FTile(
                  prefixIcon: FIcon(FAssets.icons.apple),
                  title: FTextField(
                    key: Key(application.id.toString()),
                    description: application.name.text(),
                    label: Text('application'),
                    initialValue: application.name,
                    onChange: (value) {},
                  ),
                  suffixIcon: FButton.icon(
                    onPress: () {
                      appliedProgramsRM.cancel(application);
                    },
                    child: FIcon(FAssets.icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
