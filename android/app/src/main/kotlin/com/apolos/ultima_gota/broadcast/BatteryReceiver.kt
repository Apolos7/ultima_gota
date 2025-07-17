package com.apolos.ultima_gota.broadcast

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat

class BatteryReceiver : BroadcastReceiver() {

    var threshold: Int = 20

    private val CHANNEL_ID = "battery_alert_channel"
    private val NOTIFICATION_ID = 1001

    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) return

        val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
        val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        val percentage = (level / scale.toFloat()) * 100

        val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
        val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                status == BatteryManager.BATTERY_STATUS_FULL

        if (percentage <= threshold && !isCharging) {
            showNotification(context, percentage.toInt())
        }
    }

    private fun showNotification(context: Context, level: Int) {
        val manager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Cria canal (obrigatório para Android 8+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Battery Alerts",
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.description = "Alerta de bateria baixa"
            manager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_sys_warning)
            .setContentTitle("Bateria Baixa")
            .setContentText("Nível da bateria: $level%")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()

        manager.notify(NOTIFICATION_ID, notification)
    }
}