import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './constants.dart';
import './navigation/routes.dart';
import './themes.dart';
import './utils/native_utils.dart';
import './utils/navigation_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(themes[prefs.getString('theme') ?? 'dark']),
        child: App(),
      ),
    );
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setAppDescription(APP_NAME, PRIMARY_COLOR);
    Routes.configureRoutes(router);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(Duration(milliseconds: 100), updateSystemBars);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    updateSystemBars();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BoxOff',
      theme: themeNotifier.getTheme(),
      onGenerateRoute: router.generator,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
