import 'package:flutter/material.dart';
import 'package:ultima_gota/l10n/app_localizations.dart';

extension TranslationsExtension on BuildContext {

  AppLocalizations get translations {
    return Localizations.of<AppLocalizations>(this, AppLocalizations)!;
  }
}