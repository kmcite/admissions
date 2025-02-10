import 'package:admissions/home/apply_page_bloc.dart';
import 'package:admissions/navigation.dart';
import 'package:admissions/programs/programs.dart';
import 'package:forui/forui.dart';
import 'package:manager/manager.dart';

final applyPageBloc = ApplyPageBloc();

class ApplyPage extends UI {
  @override
  void didMountWidget(BuildContext context) {
    applyPageBloc.load();
  }

  @override
  void didUnmountWidget() {
    applyPageBloc.unload();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text("Apply Page"),
        actions: [
          FHeaderAction.back(onPress: navigator.pop),
        ],
      ),
      content: Column(
        children: [
          FTileGroup(
            children: programsRM.programs.map(
              (program) {
                return FTile(
                  title: program.name.text(),
                  subtitle: FButton(
                    onPress: applyPageBloc.isAlreadyApplied(program)
                        ? null
                        : () {
                            applyPageBloc.apply(program);
                          },
                    label: 'Apply'.text(),
                  ).pad(),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
