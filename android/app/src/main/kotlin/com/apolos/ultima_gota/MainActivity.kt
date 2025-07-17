package com.apolos.ultima_gota

import android.content.Intent
import android.content.IntentFilter
import com.apolos.ultima_gota.broadcast.BatteryReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var batteryReceiver: BatteryReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.apolos.ultima_gota.battery")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startReceiver" -> {
                        val threshold = call.argument<Int>("threshold") ?: 20
                        registerBatteryReceiver(threshold)
                        result.success(null)
                    }

                    "stopReceiver" -> {
                        unregisterBatteryReceiver()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun registerBatteryReceiver(threshold: Int) {
        if (batteryReceiver == null) {
            batteryReceiver = BatteryReceiver()
            val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            registerReceiver(batteryReceiver, filter)
        }
        batteryReceiver?.threshold = threshold
    }

    private fun unregisterBatteryReceiver() {
        batteryReceiver?.let {
            unregisterReceiver(it)
            batteryReceiver = null
        }
    }

}
