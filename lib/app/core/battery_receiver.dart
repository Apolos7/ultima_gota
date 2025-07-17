import 'package:flutter/services.dart';

class BatteryReceiver {

  static const platform = MethodChannel('com.apolos.ultima_gota.battery');

  static Future<void> startBatteryReceiver(int threshold) async {
    await platform.invokeMethod('startReceiver', {'threshold': threshold});
  }

  static Future<void> stopBatteryReceiver() async {
    await platform.invokeMethod('stopReceiver');
  }
}