//
//  ChannelManager.swift
//  Runner
//
//  Created by Manu Espeso on 12/9/25.
//

final class ChannelManager {
    
    // MARK: - Properties
    
    static let shared = ChannelManager()
    
    private let channelName = "labhouse.flutter.config/channel"
    lazy private var channel: FlutterMethodChannel? = nil
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Public Methods
    
    func startChannel(_ controller: FlutterViewController) {
        channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
        
        channel?.setMethodCallHandler { [weak self] call, result -> Void in
            guard let self = self else {
                result(FlutterMethodNotImplemented)
                return
            }
            let method = FlutterChannelMethod(call.method, arguments: call.arguments as? [String: Any])
            
            switch method {
                case .storeAppDownloaded:
                    let isDownloadedFromStore = Utils.isTestFlight
                    let isDebug = Utils.isDebug
                    
                    result(isDownloadedFromStore && !isDebug)
                case .listenShakeAction:
                    NotificationCenter.default.addObserver(
                        self,
                        selector: #selector(self.handleMotionEvent(_:)),
                        name: .shakeMotionEventNotification,
                        object: nil
                    )
                case .retrieveDeviceDecimalSeparator:
                    result(Formatter.withSeparator.decimalSeparator)
                default:
                    result(FlutterMethodNotImplemented)
            }
        }
    }
    
    // MARK: - Private Methods
    
    @MainActor
    @objc private func handleMotionEvent(_ notification: Notification) {
        guard let windowMotionEvent = notification.userInfo?["window"] as? UIWindow else { return }
        
        guard let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window else { return }
        
        guard windowMotionEvent == window else { return }
        
        channel?.invokeMethod(FlutterChannelMethod.onShakeDevice.name, arguments: nil)
    }
}
