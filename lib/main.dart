import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultima_gota/app/app.dart';
import 'package:ultima_gota/app/provider/settings_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider()..loadFromPrefs(),
      child: const App(),
    ),
  );
}