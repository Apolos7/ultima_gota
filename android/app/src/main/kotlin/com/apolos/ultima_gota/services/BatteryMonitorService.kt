package com.apolos.ultima_gota.services

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.os.BatteryManager
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat
import com.apolos.ultima_gota.R

class BatteryMonitorService : Service() {

    private var batteryReceiver: BroadcastReceiver? = null
    private var threshold = 20
    private var tag: String = "BatteryMonitorService"

    private var alertHandler: Handler? = null
    private var alertRunnable: Runnable? = null
    private var mediaPlayer: MediaPlayer? = null
    private var isAlerting = false

    override fun onCreate() {
        super.onCreate()
        Log.d(tag, "Creating a battery monitoring service")
        startForeground(1, createNotification("Monitorando bateria..."))

        alertHandler = Handler(Looper.getMainLooper())

        batteryReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {

                val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                val percentage = (level / scale.toFloat()) * 100

                val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                        status == BatteryManager.BATTERY_STATUS_FULL

                Log.d(
                    tag,
                    "Reading performed with percentage at $percentage% and loading status set to $isCharging."
                )
                if (percentage <= threshold && !isCharging) {
                    Log.d(tag, "Sending alert notification.")
                    sendAlertNotification(percentage.toInt())
                    startRepeatingAlert()
                } else {
                    stopRepeatingAlert()
                }
            }
        }

        registerReceiver(batteryReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val threshold = intent?.getIntExtra("threshold", 20)
        if (threshold != null) {
            this.threshold = threshold
        }
        Log.d(tag, "Defining parameters during initialization")
        return super.onStartCommand(intent, flags, startId)
    }

    private fun startRepeatingAlert() {
        if (isAlerting) return
        isAlerting = true

        alertRunnable = object : Runnable {
            override fun run() {
                playAlertSound()
                alertHandler?.postDelayed(this, 30_000)
            }
        }
        alertHandler?.post(alertRunnable!!)
        Log.d(tag, "Started repeating alert sound.")
    }

    private fun stopRepeatingAlert() {
        if (!isAlerting) return
        isAlerting = false
        alertHandler?.removeCallbacks(alertRunnable!!)
        mediaPlayer?.stop()
        mediaPlayer?.release()
        mediaPlayer = null
        Log.d(tag, "Stopped repeating alert sound.")
    }

    private fun playAlertSound() {
        try {
            mediaPlayer?.release()
            mediaPlayer =
                MediaPlayer.create(this, RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM))
            mediaPlayer?.start()
        } catch (e: Exception) {
            Log.e(tag, "Failed to play alert sound: ${e.message}")
        }
    }

    private fun sendAlertNotification(level: Int) {
        val channelId = "battery_alert"
        val channel = NotificationChannel(
            channelId,
            "Alertas de Bateria",
            NotificationManager.IMPORTANCE_HIGH
        )

        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(channel)

        val soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle("Bateria baixa!")
            .setContentText("Nível: $level%. Hora de carregar.")
            .setSmallIcon(R.mipmap.launcher_icon)
            .setSound(soundUri)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .build()

        manager.notify(2, notification)
    }

    private fun createNotification(text: String): Notification {
        val channelId = "battery_monitor"
        val channel =
            NotificationChannel(channelId, "Monitor de Bateria", NotificationManager.IMPORTANCE_LOW)
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(channel)

        return NotificationCompat.Builder(this, channelId)
            .setContentTitle("Monitorando bateria")
            .setContentText(text)
            .setSmallIcon(R.mipmap.launcher_icon)
            .build()
    }

    override fun onDestroy() {
        Log.d(tag, "Destroying a battery monitoring service")
        batteryReceiver?.let { unregisterReceiver(it) }
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}