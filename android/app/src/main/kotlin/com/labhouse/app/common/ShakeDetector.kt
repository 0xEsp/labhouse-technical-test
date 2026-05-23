package com.labhouse.app.common

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import kotlin.math.sqrt

class ShakeDetector(
    private val sensorManager: SensorManager,
    private val onShake: () -> Unit
) : SensorEventListener {
    private var lastShakeTimestamp = 0L
    private var isRunning = false

    fun start() {
        if (isRunning) return

        val accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) ?: return
        sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_GAME)

        isRunning = true
    }

    fun stop() {
        if (!isRunning) return

        sensorManager.unregisterListener(this)

        isRunning = false
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor.type != Sensor.TYPE_ACCELEROMETER) return

        val x = event.values[0]
        val y = event.values[1]
        val z = event.values[2]
        val gForce = sqrt((x * x + y * y + z * z).toDouble()) / SensorManager.GRAVITY_EARTH
        val now = System.currentTimeMillis()

        if (gForce > 2.7 && now - lastShakeTimestamp > 800) {
            lastShakeTimestamp = now
            onShake()
        }
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {}
}


