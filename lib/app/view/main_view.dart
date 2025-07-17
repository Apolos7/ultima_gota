import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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

  final _themeModeIconsMap = {
    ThemeMode.light: Icons.sunny,
    ThemeMode.dark: Icons.nightlight_round,
    ThemeMode.system: Icons.auto_mode,
  };

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

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
            const Text('Última Gota'),
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
                  tooltip: 'Alterar Tema',
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
                    child: Text('Salvar', style: themeData.textTheme.bodyLarge),
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
                          'É necessário permitir o acesso ao envio de notificações para que possamos te ajudar.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: Theme.of(context).textTheme.bodyLarge,
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
