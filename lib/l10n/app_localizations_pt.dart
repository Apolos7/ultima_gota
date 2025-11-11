// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Última Gota';

  @override
  String get alertMeWhenBatteryIsBelow =>
      'Avise-me quando a bateria estiver abaixo de:';

  @override
  String get batteryAlarm => 'Alarme de Bateria';

  @override
  String get batteryThreshold => 'Limite de Bateria';

  @override
  String get changeTheme => 'Alterar Tema';

  @override
  String get doNotDisturbBetween => 'Não pertube entre:';

  @override
  String get enableBatteryNotifications => 'Ativar Notificações de Bateria';

  @override
  String get endTime => 'Hora de Término';

  @override
  String get quietHours => 'Horário de Silêncio';

  @override
  String get saveButton => 'Salvar';

  @override
  String get startTime => 'Hora de Início';

  @override
  String get notificationPermissionRequired =>
      'É necessário permitir o acesso ao envio de notificações para que possamos te ajudar.';

  @override
  String get understood => 'Entendido';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Última Gota';

  @override
  String get alertMeWhenBatteryIsBelow =>
      'Avise-me quando a bateria estiver abaixo de:';

  @override
  String get batteryAlarm => 'Alarme de Bateria';

  @override
  String get batteryThreshold => 'Limite de Bateria';

  @override
  String get changeTheme => 'Alterar Tema';

  @override
  String get doNotDisturbBetween => 'Não pertube entre:';

  @override
  String get enableBatteryNotifications => 'Ativar Notificações de Bateria';

  @override
  String get endTime => 'Hora de Término';

  @override
  String get quietHours => 'Horário de Silêncio';

  @override
  String get saveButton => 'Salvar';

  @override
  String get startTime => 'Hora de Início';

  @override
  String get notificationPermissionRequired =>
      'É necessário permitir o acesso ao envio de notificações para que possamos te ajudar.';

  @override
  String get understood => 'Entendido';
}
