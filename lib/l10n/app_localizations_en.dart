// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Last Drop';

  @override
  String get alertMeWhenBatteryIsBelow => 'Alert me when battery is below:';

  @override
  String get batteryAlarm => 'Battery Alarm';

  @override
  String get batteryThreshold => 'Battery Threshold';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get doNotDisturbBetween => 'Do not disturb between:';

  @override
  String get enableBatteryNotifications => 'Enable battery notifications';

  @override
  String get endTime => 'End Time';

  @override
  String get quietHours => 'Quiet Hours';

  @override
  String get saveButton => 'Save';

  @override
  String get startTime => 'Start Time';

  @override
  String get notificationPermissionRequired =>
      'It is necessary to allow notification access so we can assist you.';

  @override
  String get understood => 'Understood';
}
