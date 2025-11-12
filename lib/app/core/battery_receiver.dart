import 'package:flutter/services.dart';

class BatteryReceiver {

  static const platform = MethodChannel('com.apolos.ultima_gota.battery');

  static Future<void> startBatteryReceiver(int threshold) async {
    try {
      await platform.invokeMethod('startForegroundService', {'threshold': threshold});
    } on PlatformException catch (e) {
      // suppress
    }
  }

  static Future<void> stopBatteryReceiver() async {
    try {
      await platform.invokeMethod('stopForegroundService');
    } on PlatformException catch (e) {
      // suppress
    }
  }
}