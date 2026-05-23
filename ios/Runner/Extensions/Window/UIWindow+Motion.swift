//
//  UIWindow+Motion.swift
//  Runner
//
//  Created by Manu Espeso on 12/9/25.
//

extension UIWindow {
    
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        
        NotificationCenter.default.post(name: .shakeMotionEventNotification, object: nil, userInfo: ["window": self])
    }
}
