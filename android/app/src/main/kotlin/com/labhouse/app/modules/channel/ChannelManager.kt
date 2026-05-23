package com.labhouse.app.modules.channel

import android.content.Context
import android.hardware.SensorManager
import android.os.Build
import com.labhouse.app.common.ShakeDetector
import com.labhouse.app.modules.channel.model.FlutterChannelMethod
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.DecimalFormatSymbols

class ChannelManager(private val appContext: Context) : MethodChannel.MethodCallHandler {
    private val channelName = "labhouse.flutter.config/channel"
    private var channel: MethodChannel? = null
    private var shakeDetector: ShakeDetector? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (FlutterChannelMethod.from(call.method, call.arguments)) {
            is FlutterChannelMethod.StoreAppDownloaded -> result.success(isInstalledFromStore())

            is FlutterChannelMethod.ListenShakeAction -> {
                startShakeListener()
                result.success(null)
            }

            is FlutterChannelMethod.RetrieveDeviceDecimalSeparator -> {
                result.success(DecimalFormatSymbols.getInstance().decimalSeparator.toString())
            }

            else -> result.notImplemented()
        }
    }

    fun start(flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        channel?.setMethodCallHandler(this)
    }

    fun stop() {
        channel?.setMethodCallHandler(null)
        channel = null
        stopShakeListener()
    }

    private fun isInstalledFromStore(): Boolean {
        val installer = kotlin.runCatching {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                return@runCatching appContext.packageManager.getInstallSourceInfo(appContext.packageName).installingPackageName
            }

            @Suppress("DEPRECATION")
            return@runCatching appContext.packageManager.getInstallerPackageName(appContext.packageName)
        }.getOrNull()

        return installer == "com.android.vending" || installer == "com.google.android.feedback"
    }

    private fun startShakeListener() {
        if (shakeDetector != null) return

        val sensorManager = appContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager

        shakeDetector = ShakeDetector(sensorManager) {
            channel?.invokeMethod(FlutterChannelMethod.OnShakeDevice.name, null)
        }

        shakeDetector?.start()
    }

    private fun stopShakeListener() {
        shakeDetector?.stop()
        shakeDetector = null
    }
}
