import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  // App
  ThemeMode themeMode = ThemeMode.system;

  // Form
  bool savedAlarmEnabled = false;
  bool savedQuietHoursEnabled = false;
  double savedThreshold = 20;
  TimeOfDay savedStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay savedEnd = const TimeOfDay(hour: 7, minute: 0);

  bool alarmEnabled = false;
  bool quietHoursEnabled = false;
  double threshold = 20;
  TimeOfDay start = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay end = const TimeOfDay(hour: 7, minute: 0);

  bool get isDirty =>
      alarmEnabled != savedAlarmEnabled ||
      quietHoursEnabled != savedQuietHoursEnabled ||
      threshold != savedThreshold ||
      start != savedStart ||
      end != savedEnd;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    savedAlarmEnabled = prefs.getBool('alarm_enabled') ?? false;
    savedQuietHoursEnabled = prefs.getBool('quiet_hours_enabled') ?? false;
    savedThreshold = prefs.getDouble('threshold') ?? 20;
    themeMode = ThemeMode.values.byName(
      prefs.getString('theme_mode') ?? 'system',
    );

    final startString = prefs.getString('start')?.split(',');
    if (startString != null) {
      savedStart = TimeOfDay(
        hour: int.parse(startString[0]),
        minute: int.parse(startString[1]),
      );
    }
    final endString = prefs.getString('end')?.split(',');
    if (endString != null) {
      savedEnd = TimeOfDay(
        hour: int.parse(endString[0]),
        minute: int.parse(endString[1]),
      );
    }

    alarmEnabled = savedAlarmEnabled;
    quietHoursEnabled = savedQuietHoursEnabled;
    threshold = savedThreshold;
    start = savedStart;
    end = savedEnd;
    notifyListeners();
  }

  void updateAlarmEnabled(bool value) {
    alarmEnabled = value;
    notifyListeners();
  }

  void updateThreshold(double value) {
    threshold = value.floorToDouble();
    notifyListeners();
  }

  void updateQuietHours(bool value) {
    quietHoursEnabled = value;
    notifyListeners();
  }

  void updateStart(TimeOfDay value) {
    start = value;
    notifyListeners();
  }

  void updateEnd(TimeOfDay value) {
    end = value;
    notifyListeners();
  }

  void updateTheme() {
    switch (themeMode) {
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        themeMode = ThemeMode.system;
      case ThemeMode.system:
        themeMode = ThemeMode.light;
    }
    SharedPreferences.getInstance().then((value) {
      value.setString('theme_mode', themeMode.name);
    });

    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alarm_enabled', alarmEnabled);
    await prefs.setBool('quiet_hours_enabled', alarmEnabled);
    await prefs.setDouble('threshold', threshold);
    await prefs.setString('start', '${start.hour},${start.minute}');
    await prefs.setString('end', '${end.hour},${end.minute}');

    savedAlarmEnabled = alarmEnabled;
    savedQuietHoursEnabled = quietHoursEnabled;
    savedThreshold = threshold;
    savedStart = start;
    savedEnd = end;
    notifyListeners();
  }
}
