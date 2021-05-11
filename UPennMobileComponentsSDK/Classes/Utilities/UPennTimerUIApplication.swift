//
//  UPennTimerUIApplication.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/13/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol UPennAppTimeoutDelegate {
    @objc func applicationDidTimeout(notification: NSNotification)
}

public class UPennTimerUIApplication : UIApplication {
    
    private enum IntervalSeconds : Double {
        case TwoMin  = 120.0
        case FiveMin = 300.0
        case TenMin  = 600.0
    }
    
    static let ApplicationDidTimeoutNotification = UPennNameSpacer.MakeKey("AppTimeout")
    
    static var AuthCoordinator : UPennLoginCoordinatable!
    
    static var TimeoutIndex : Int {
        return TimeoutIndices[TimeoutInSeconds]!
    }
    static private var IdleTimer: Timer?
    
    static var TimeoutCallback : ((_ notification: NSNotification)->Void)? = nil
    
    /**
     Configure the Auto-logout Timer by setting up a notification listener w/ callback
     - parameter callback: Block to be invoked by the caller when auto-logout notification fires
     */
    public static func ConfigureAutoLogoutTimer(callback: @escaping (_ notification: NSNotification)->Void) {
        self.TimeoutCallback = callback
        NotificationCenter.default.addObserver(self, selector: #selector(self.SetNotificationHandler(notification:)), name: NSNotification.Name.init(UPennTimerUIApplication.ApplicationDidTimeoutNotification), object: nil)
    }
    
    // Listen for any touch. If the screen receives a touch, the timer is reset.
    public override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if UPennTimerUIApplication.IdleTimer != nil {
            UPennTimerUIApplication.ResetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches {
                if touch.phase == .began {
                    UPennTimerUIApplication.ResetIdleTimer()
                }
            }
        }
    }
    
    /**
     Reset the timer because there was user interaction.
     */
    static func ResetIdleTimer() {
        
        // Only trigger timer logout-timer if User is logged-in
        
        if UPennAuthenticationService.IsAuthenticated {
            self.InvalidateActiveTimer()
            
            IdleTimer = Timer.scheduledTimer(timeInterval: TimeoutInSeconds, target: self, selector: #selector(self.idleTimerExceeded), userInfo: nil, repeats: false)
        }
    }
    
    /**
     Invalidates any active UPennTimerUIApplication timer
     */
    static func InvalidateActiveTimer() {
        if let idleTimer = IdleTimer {
            idleTimer.invalidate()
        }
    }
    
    /**
     If the timer reaches the limit as defined in timeoutInSeconds, post this notification.
     */
    @objc static func idleTimerExceeded() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.ApplicationDidTimeoutNotification), object: nil)
    }
    
    static func updateTimeoutInterval(index: Int) {
        let seconds = TimeoutIdxDict[index]
        UserDefaults.standard.set(seconds, forKey: self.TimeoutKey)
        ResetIdleTimer()
    }
}

private extension UPennTimerUIApplication {
    
    static var TimeoutIdxDict : Dictionary<Int,Double> = {
        let dict = [
            0 : IntervalSeconds.TwoMin.rawValue,
            1 : IntervalSeconds.FiveMin.rawValue,
            2 : IntervalSeconds.TenMin.rawValue
        ]
        return dict
    }()
    
    static var TimeoutIndices : Dictionary<Double,Int> = {
        let dict = [
            IntervalSeconds.TwoMin.rawValue  : 0,
            IntervalSeconds.FiveMin.rawValue : 1,
            IntervalSeconds.TenMin.rawValue  : 2
        ]
        return dict
    }()
    
    static var TimeoutKey : String = {
        return UPennNameSpacer.MakeKey("timeoutKey")
    }()
    
    static var TimeoutInSeconds: Double {
        guard let timeoutSeconds = UserDefaults.standard.value(forKey: TimeoutKey) as? Double else { return TimeoutIdxDict[2]! }
        return timeoutSeconds
    }
    
    @objc static func SetNotificationHandler(notification: NSNotification) {
        if let callback = TimeoutCallback {
            callback(notification)
        }
    }
}
