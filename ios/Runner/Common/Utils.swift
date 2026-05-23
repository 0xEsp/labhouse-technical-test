//
//  Utils.swift
//  Runner
//
//  Created by Manu Espeso on 12/9/25.
//

struct Utils {
    
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
}
