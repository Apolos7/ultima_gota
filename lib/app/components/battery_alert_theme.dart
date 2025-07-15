import 'package:flutter/material.dart';

ThemeData lightBatteryAlertTheme() {
  const primary = Color(0xFF22C55E);
  const accent = Color(0xFF3B82F6);
  const error = Color(0xFFEF4444);
  const surface = Colors.white;
  const cardSurface = Color(0xFFF9FAFB);
  const onSurface = Color(0xFF111827);
  const border = Color(0xFFE5E7EB);

  const baseText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: onSurface,
  );

  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: surface,
    // ----- COLOR SCHEME -----
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: accent,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
    ),
    // ----- APP BAR -----
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      foregroundColor: onSurface,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      iconTheme: IconThemeData(color: onSurface),
    ),
    // ----- TEXT -----
    textTheme: TextTheme(
      bodyLarge: baseText.copyWith(fontSize: 20),
      bodyMedium: baseText,
      bodySmall: baseText.copyWith(fontSize: 14),
      titleMedium: baseText.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ), // section headers
    ),
    // ----- SWITCH -----
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green.withValues(alpha: 0.5);
        }
        return Colors.grey.shade300;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green;
        }
        return Colors.white;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.2)),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
    // ----- BUTTONS -----
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: primary,
        disabledBackgroundColor: onSurface.withValues(alpha: 0.4),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    // ----- SLIDER -----
    sliderTheme: SliderThemeData(
      trackHeight: 4,
      activeTrackColor: primary,
      inactiveTrackColor: const Color(0xFFBBF7D0),
      // light green
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: .2),
    ),
    // ----- INPUTS (TextField, TimePicker) -----
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      labelStyle: const TextStyle(color: onSurface),
    ),
    // ----- CARD & CONTAINER SHAPES -----
    cardTheme: CardThemeData(
      color: cardSurface,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: border),
      ),
      elevation: 0,
    ),
    // ----- DIVIDERS -----
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: border,
      space: 32,
    ),
    // ----- TOAST / SNACKBAR -----
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: onSurface,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    // ----- ICONS -----
    iconTheme: const IconThemeData(size: 24, color: accent),
    // ----- TAP TARGET & PADDING -----
    visualDensity: VisualDensity.standard,
  );
}

ThemeData darkBatteryAlertTheme() {
  const primary = Color(0xFF22C55E);
  const accent = Color(0xFF3B82F6);
  const error = Color(0xFFEF4444);
  const surface = Color(0xFF1F2937);     // cinza-900
  const cardSurface = Color(0xFF374151); // cinza-800
  const onSurface = Color(0xFFF9FAFB);   // cinza-50
  const border = Color(0xFF4B5563);      // cinza-600

  const baseText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: onSurface,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: surface,
    // ----- COLOR SCHEME -----
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimaryFixed: primary,
      onPrimary: Colors.black,
      secondary: accent,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
    ),
    // ----- APP BAR -----
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      foregroundColor: onSurface,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      iconTheme: IconThemeData(color: onSurface),
    ),
    // ----- TEXT -----
    textTheme: TextTheme(
      bodyLarge: baseText.copyWith(fontSize: 20),
      bodyMedium: baseText,
      bodySmall: baseText.copyWith(fontSize: 14),
      titleMedium: baseText.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    // ----- SWITCH -----
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green.withValues(alpha: 0.5);
        }
        return border;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green;
        }
        return Colors.white;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.2)),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
    // ----- BUTTONS -----
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: primary,
        disabledBackgroundColor: cardSurface,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    // ----- SLIDER -----
    sliderTheme: SliderThemeData(
      trackHeight: 4,
      activeTrackColor: primary,
      inactiveTrackColor: const Color(0xFF166534), // verde escuro
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: 0.2),
    ),
    // ----- INPUTS (TextField, TimePicker) -----
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      filled: true,
      fillColor: const Color(0xFF374151),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      labelStyle: const TextStyle(color: onSurface),
    ),
    // ----- CARD & CONTAINER SHAPES -----
    cardTheme: CardThemeData(
      color: cardSurface,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: border),
      ),
      elevation: 0,
    ),
    // ----- DIVIDERS -----
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: border,
      space: 32,
    ),
    // ----- TOAST / SNACKBAR -----
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: onSurface,
      contentTextStyle: const TextStyle(color: Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    // ----- ICONS -----
    iconTheme: const IconThemeData(size: 24, color: accent),
    // ----- TAP TARGET & PADDING -----
    visualDensity: VisualDensity.standard,
  );
}
