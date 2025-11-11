import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultima_gota/app/components/battery_alert_theme.dart';
import 'package:ultima_gota/app/provider/settings_provider.dart';
import 'package:ultima_gota/app/view/main_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ultima_gota/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder:
          (context, settingsProvider, child) => MaterialApp(
            title: 'Última Gota',
            theme: lightBatteryAlertTheme(),
            darkTheme: darkBatteryAlertTheme(),
            themeMode: settingsProvider.themeMode,
            home: const MainView(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('pt', 'BR'), // Portuguese Brazilian
              const Locale('pt'), // Portuguese
              const Locale('en'), // English
            ],
          ),
    );
  }
}
