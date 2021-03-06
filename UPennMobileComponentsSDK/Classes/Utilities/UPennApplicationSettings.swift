//
//  UPennApplicationSettings.swift
//  PipPenn Patient
//
//  Created by Rashad Abdul-Salam on 2/21/20.
//  Copyright © 2020 University of Pennsylvania. All rights reserved.
//

import Foundation
import UIKit

/**
    Abstract:
    Class manages unwrapping of all Bundle.main configuration objects
 */

open class UPennApplicationSettings {
    
//    enum RuntimeStates : Int {
//        case DEBUG_PROD
//        case DEBUG_TEST
//        case TEST
//        case APP_STORE
//    }
//    
//    static var RunState : RuntimeStates {
//        switch Config {
//        case "Debug-TEST": return .DEBUG_TEST
//        case "Debug-PROD": return .DEBUG_PROD
//        case "TEST": return .TEST
//        case "App Store": return .APP_STORE
//        default: return .DEBUG_TEST
//        }
//    }
    
    public static var Config = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
    
    public static var CurrentAppVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    
    public static var BundleID = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
    
    public static var DeviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public static var AppDisplayName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    
    public static var RootURL = Bundle.main.object(forInfoDictionaryKey: UPennConstants.RootURL as String) as! String
    
    public static var LoginURL = Bundle.main.object(forInfoDictionaryKey: UPennConstants.LoginURL as String) as! String
}
