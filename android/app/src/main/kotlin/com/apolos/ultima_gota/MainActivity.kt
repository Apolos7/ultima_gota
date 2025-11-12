package com.apolos.ultima_gota

import android.content.Intent
import com.apolos.ultima_gota.services.BatteryMonitorService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.apolos.ultima_gota.battery")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startForegroundService" -> {
                        val threshold = call.argument<Int>("threshold")
                        startForegroundService(threshold)
                        result.success(null)
                    }

                    "stopForegroundService" -> {
                        stopForegroundService()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun startForegroundService(threshold: Int?) {
        val intent = Intent(this, BatteryMonitorService::class.java)
        intent.putExtra("threshold", threshold)
        startService(intent)
    }

    private fun stopForegroundService() {
        val intent = Intent(this, BatteryMonitorService::class.java)
        stopService(intent)
    }
}
