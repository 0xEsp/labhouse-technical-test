//
//  FlutterChannelMethod.swift
//  Runner
//
//  Created by Manu Espeso on 12/9/25.
//

enum FlutterChannelMethod {
    /// Flutter -> Native
    case storeAppDownloaded
    case listenShakeAction
    case retrieveDeviceDecimalSeparator
    /// Native -> Flutter
    case onShakeDevice
    
    fileprivate enum FlutterChannelMethodNaming: String {
        case isAppDownloadedFromStore, listenShakeDeviceAction, getDeviceDecimalSeparator, onShakeDevice
    }
    
    init?(_ rawValue: String, arguments: [String: Any]?) {
        let value: FlutterChannelMethod? = switch rawValue {
            case FlutterChannelMethodNaming.isAppDownloadedFromStore.rawValue:
                    .storeAppDownloaded
            case FlutterChannelMethodNaming.listenShakeDeviceAction.rawValue:
                    .listenShakeAction
            case FlutterChannelMethodNaming.getDeviceDecimalSeparator.rawValue:
                    .retrieveDeviceDecimalSeparator
            case FlutterChannelMethodNaming.onShakeDevice.rawValue:
                    .onShakeDevice
            default:
                nil
        }
        
        guard let value else { return nil }
        
        self = value
    }
    
    var name: String {
        switch self {
            case .storeAppDownloaded:
                return FlutterChannelMethodNaming.isAppDownloadedFromStore.rawValue
            case .listenShakeAction:
                return FlutterChannelMethodNaming.listenShakeDeviceAction.rawValue
            case .retrieveDeviceDecimalSeparator:
                return FlutterChannelMethodNaming.getDeviceDecimalSeparator.rawValue
            case .onShakeDevice:
                return FlutterChannelMethodNaming.onShakeDevice.rawValue
        }
    }
}
