import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ultima_gota/app/components/battery_alert_theme.dart';
import 'package:ultima_gota/app/components/custom_time_picker.dart';
import 'package:ultima_gota/app/provider/settings_provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final double _minValue = 10;
  final double _maxValue = 99;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Última Gota'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _changeTheme,
            tooltip: 'Alterar Tema',
            icon: Icon(
              themeModeNotifier.value == ThemeMode.light
                  ? Icons.sunny
                  : Icons.nightlight_round,
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
                      'Alarme de Bateria',
                      style: themeData.textTheme.titleLarge,
                    ),
                    Text(
                      'Ativar Notificações de Bateria',
                      style: themeData.textTheme.bodyMedium,
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
                  'Limite de Bateria',
                  style: themeData.textTheme.titleLarge,
                ),
              ],
            ),
            const Gap(16),
            Text(
              'Avise-me quando a bateria estiver abaixo de:',
              style: themeData.textTheme.bodyMedium,
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
                          style: themeData.textTheme.bodyMedium,
                        ),
                        Consumer<SettingsProvider>(
                          builder:
                              (context, value, child) => Text(
                                '${value.threshold.toInt()} %',
                                style: themeData.textTheme.bodyLarge?.copyWith(
                                  color: themeData.colorScheme.primary,
                                ),
                              ),
                        ),
                        Text(
                          '${_maxValue.toInt()} %',
                          style: themeData.textTheme.bodyMedium,
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
                  'Horário de Silêncio',
                  style: themeData.textTheme.titleLarge,
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
            Text('Não pertube entre:', style: themeData.textTheme.bodyMedium),
            const Gap(10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hora de Início',
                      style: themeData.textTheme.bodyMedium,
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
                      'Hora de Término',
                      style: themeData.textTheme.bodyMedium,
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
                    child: const Text('Salvar'),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    settingsProvider.save();
  }

  void _changeTheme() {
    SystemSound.play(SystemSoundType.click);
    themeModeNotifier.value =
        themeModeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
  }
}
