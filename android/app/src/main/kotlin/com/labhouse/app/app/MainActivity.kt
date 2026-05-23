package com.labhouse.app.app

import com.labhouse.app.modules.channel.ChannelManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var channelManager: ChannelManager? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channelManager = ChannelManager(applicationContext)
        channelManager?.start(flutterEngine)
    }

    override fun onDestroy() {
        channelManager?.stop()
        channelManager = null

        super.onDestroy()
    }
}
