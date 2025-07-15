import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultima_gota/app/components/battery_alert_theme.dart'
    show lightBatteryAlertTheme, darkBatteryAlertTheme, themeModeNotifier;
import 'package:ultima_gota/app/provider/settings_provider.dart';
import 'package:ultima_gota/app/view/main_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider()..loadFromPrefs(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Última Gota',
          theme: lightBatteryAlertTheme(),
          darkTheme: darkBatteryAlertTheme(),
          themeMode: themeMode,
          home: const MainView(),
        );
      },
    );
  }
}
