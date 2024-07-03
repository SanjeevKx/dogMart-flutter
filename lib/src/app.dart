import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './sample_feature/navigation.dart'; // Import the navigation file
import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';
// import 'settings/settings_view.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) => 'My Flutter App',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsScreen.routeName:
                    return const SettingsScreen();
                  case HomeScreen.routeName:
                    return const HomeScreen();
                  case BreedScreen.routeName:
                    return const BreedScreen();
                  case CartScreen.routeName:
                    return const CartScreen();
                  default:
                    return const HomeScreen();
                }
              },
            );
          },
          home: const HomeScreen(),
        );
      },
    );
  }
}
