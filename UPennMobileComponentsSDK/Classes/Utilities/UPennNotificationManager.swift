//
//  UPennNotificationManager.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 1/5/22.
//

import Foundation

/// Object for managing creation/removal of Notifications, and triggering of callback completions
public struct UPennNotificationManager {
    
    static var IsLoggedInNotification = UPennNameSpacer.MakeKey("UPHSIsLoggedInNotification")
    static var ExpiredAuthenticationNotifier = UPennNameSpacer.MakeKey("UPennExpiredAuthenticationNotifier")
    
    public static func SetLoginObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.init(Self.IsLoggedInNotification), object: nil)
    }
    
    public static func RemoveLoginObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name.init(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
    public static func SendLoginNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
    public static func SetExpiredAuthenticationObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.init(Self.ExpiredAuthenticationNotifier), object: nil)
    }
    
    public static func SendExpiredAuthenticationNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Self.ExpiredAuthenticationNotifier), object: nil)
    }
    
}
