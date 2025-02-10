import 'package:admissions/authentication/login_page.dart';
import 'package:forui/forui.dart';
import 'package:manager/collection.dart';
export 'package:manager/database.dart';
export 'package:manager/manager.dart';
import 'main.dart';
import 'navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Model.initialize();
  runApp(const AdmissionsApp());
}

class AdmissionsApp extends UI {
  const AdmissionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.key,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      builder: (context, child) => FTheme(
        data: FThemes.slate.dark,
        child: child!,
      ),
      home: AuthenticationPage(),
    );
  }
}

extension Put<T> on Injected<T> {
  void put(T value) {
    state = value;
    notify();
  }
}
