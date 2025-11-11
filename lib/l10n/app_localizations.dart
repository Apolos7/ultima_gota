import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Título principal do aplicativo
  ///
  /// In pt_BR, this message translates to:
  /// **'Última Gota'**
  String get appTitle;

  /// Texto que indica a configuração do nível mínimo de bateria para notificação
  ///
  /// In pt_BR, this message translates to:
  /// **'Avise-me quando a bateria estiver abaixo de:'**
  String get alertMeWhenBatteryIsBelow;

  /// Título da seção ou funcionalidade relacionada ao alarme de bateria
  ///
  /// In pt_BR, this message translates to:
  /// **'Alarme de Bateria'**
  String get batteryAlarm;

  /// Rótulo da configuração que define o percentual mínimo de bateria
  ///
  /// In pt_BR, this message translates to:
  /// **'Limite de Bateria'**
  String get batteryThreshold;

  /// Texto de ação para alterar o tema do aplicativo
  ///
  /// In pt_BR, this message translates to:
  /// **'Alterar Tema'**
  String get changeTheme;

  /// Rótulo para definir o intervalo de tempo em que notificações não devem ocorrer
  ///
  /// In pt_BR, this message translates to:
  /// **'Não pertube entre:'**
  String get doNotDisturbBetween;

  /// Texto de opção para ativar ou desativar alertas relacionados à bateria
  ///
  /// In pt_BR, this message translates to:
  /// **'Ativar Notificações de Bateria'**
  String get enableBatteryNotifications;

  /// Campo para selecionar a hora final do intervalo de silêncio
  ///
  /// In pt_BR, this message translates to:
  /// **'Hora de Término'**
  String get endTime;

  /// Título da seção onde o usuário configura o modo silencioso por horário
  ///
  /// In pt_BR, this message translates to:
  /// **'Horário de Silêncio'**
  String get quietHours;

  /// Texto do botão para salvar configurações
  ///
  /// In pt_BR, this message translates to:
  /// **'Salvar'**
  String get saveButton;

  /// Campo para selecionar a hora inicial do intervalo de silêncio
  ///
  /// In pt_BR, this message translates to:
  /// **'Hora de Início'**
  String get startTime;

  /// Mensagem informando que o app precisa de permissão para enviar notificações
  ///
  /// In pt_BR, this message translates to:
  /// **'É necessário permitir o acesso ao envio de notificações para que possamos te ajudar.'**
  String get notificationPermissionRequired;

  /// Texto do botão para confirmar e fechar um aviso ou diálogo
  ///
  /// In pt_BR, this message translates to:
  /// **'Entendido'**
  String get understood;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
