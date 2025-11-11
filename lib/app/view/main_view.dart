import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultima_gota/app/components/custom_time_picker.dart';
import 'package:ultima_gota/app/provider/settings_provider.dart';
import 'package:ultima_gota/extensions/theme_extension.dart';
import 'package:ultima_gota/extensions/translations_extension.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final double _minValue = 10;
  final double _maxValue = 99;

  final _themeModeIconsMap = {
    ThemeMode.light: Icons.sunny,
    ThemeMode.dark: Icons.nightlight_round,
    ThemeMode.system: Icons.auto_mode,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/battery_icon_without_background.png',
              width: 50,
            ),
            const Gap(10),
            Text(context.translations.appTitle),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
        ),
        actions: [
          Consumer<SettingsProvider>(
            builder:
                (context, value, child) => IconButton(
                  onPressed: _changeTheme,
                  tooltip: context.translations.changeTheme,
                  icon: Icon(_themeModeIconsMap[value.themeMode]),
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translations.batteryAlarm,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    Text(
                      context.translations.enableBatteryNotifications,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Consumer<SettingsProvider>(
                  builder:
                      (context, value, child) => Switch(
                        value: value.alarmEnabled,
                        onChanged: value.updateAlarmEnabled,
                      ),
                ),
              ],
            ),
            const Gap(24),
            Row(
              children: [
                const Icon(Icons.battery_3_bar),
                const Gap(16),
                Text(
                  context.translations.batteryThreshold,
                  style: context.theme.textTheme.titleLarge,
                ),
              ],
            ),
            const Gap(16),
            Text(
              context.translations.alertMeWhenBatteryIsBelow,
              style: context.theme.textTheme.bodyMedium,
            ),
            const Gap(10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_minValue.toInt()} %',
                          style: context.theme.textTheme.bodyMedium,
                        ),
                        Consumer<SettingsProvider>(
                          builder:
                              (context, value, child) => Text(
                                '${value.threshold.toInt()} %',
                                style: context.theme.textTheme.bodyLarge?.copyWith(
                                  color: context.theme.colorScheme.primary,
                                ),
                              ),
                        ),
                        Text(
                          '${_maxValue.toInt()} %',
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Consumer<SettingsProvider>(
                      builder:
                          (context, value, child) => Slider(
                            value: value.threshold,
                            min: _minValue,
                            max: _maxValue,
                            onChanged: value.updateThreshold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            Row(
              children: [
                const Icon(Icons.access_time_filled),
                const Gap(16),
                Text(
                  context.translations.quietHours,
                  style: context.theme.textTheme.titleLarge,
                ),
                const Spacer(),
                Consumer<SettingsProvider>(
                  builder:
                      (context, value, child) => Switch(
                        value: value.quietHoursEnabled,
                        onChanged: value.updateQuietHours,
                      ),
                ),
              ],
            ),
            const Gap(16),
            Text(context.translations.doNotDisturbBetween, style: context.theme.textTheme.bodyMedium),
            const Gap(10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translations.startTime,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    const Gap(10),
                    Consumer<SettingsProvider>(
                      builder:
                          (context, value, child) => CustomTimePicker(
                            value: value.start,
                            onChanged: value.updateStart,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translations.endTime,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    const Gap(10),
                    Consumer<SettingsProvider>(
                      builder:
                          (context, value, child) => CustomTimePicker(
                            value: value.end,
                            onChanged: value.updateEnd,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16),
            Consumer<SettingsProvider>(
              builder:
                  (context, value, child) => ElevatedButton(
                    onPressed: value.isDirty ? _save : null,
                    child: Text(context.translations.saveButton, style: context.theme.textTheme.bodyLarge),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    final isGranted = await Permission.notification.isGranted;

    if (!isGranted) {
      final permissionStatus = await Permission.notification.request();
      if (permissionStatus == PermissionStatus.granted) {
        settingsProvider.save();
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder:
              (context) => Center(
                child: Card(
                  margin: const EdgeInsets.all(24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.translations.notificationPermissionRequired,
                          style: context.theme.textTheme.bodyLarge,
                        ),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            context.translations.understood,
                            style: context.theme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        );
      }
    } else {
      settingsProvider.save();
    }
  }

  void _changeTheme() {
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    settingsProvider.updateTheme();
  }
}
