package com.labhouse.app.modules.channel.model

sealed class FlutterChannelMethod {
    data object StoreAppDownloaded : FlutterChannelMethod()
    data object ListenShakeAction : FlutterChannelMethod()
    data object RetrieveDeviceDecimalSeparator : FlutterChannelMethod()
    data object OnShakeDevice : FlutterChannelMethod()
    // data class NewCase(val payload: Map<String, Any?>) : FlutterChannelMethod()

    private object Naming {
        const val IS_APP_DOWNLOADED_FROM_STORE = "isAppDownloadedFromStore"
        const val LISTEN_SHAKE_DEVICE_ACTION = "listenShakeDeviceAction"
        const val GET_DEVICE_DECIMAL_SEPARATOR = "getDeviceDecimalSeparator"
        const val ON_SHAKE_DEVICE = "onShakeDevice"
        // const val newCase = "newCase"
    }

    companion object {
        fun from(raw: String, arguments: Any?): FlutterChannelMethod? = when (raw) {
            Naming.IS_APP_DOWNLOADED_FROM_STORE -> StoreAppDownloaded
            Naming.LISTEN_SHAKE_DEVICE_ACTION -> ListenShakeAction
            Naming.GET_DEVICE_DECIMAL_SEPARATOR -> RetrieveDeviceDecimalSeparator
            Naming.ON_SHAKE_DEVICE -> OnShakeDevice
            // Naming.newCase -> NewCase(arguments as? Map<String, Any?> ?: emptyMap())
            else -> null
        }
    }

    val name: String
        get() = when (this) {
            StoreAppDownloaded -> Naming.IS_APP_DOWNLOADED_FROM_STORE
            ListenShakeAction -> Naming.LISTEN_SHAKE_DEVICE_ACTION
            RetrieveDeviceDecimalSeparator -> Naming.GET_DEVICE_DECIMAL_SEPARATOR
            OnShakeDevice -> Naming.ON_SHAKE_DEVICE
            // is NewCase -> Naming.newCase
        }
}
