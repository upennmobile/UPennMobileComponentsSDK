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
    
    public static var Config = Bundle.main.object(forInfoDictionaryKey: UPennConstants.Config) as! String
    
    public static var CurrentAppVersion = Bundle.main.object(forInfoDictionaryKey: UPennConstants.BundleVersionStringShort as String) as! String
    
    public static var BundleID = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
    
    public static var DeviceID = UIDevice.current.identifierForVendor!.uuidString
    
    public static var AppDisplayName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    
    public static var RootURL = Bundle.main.object(forInfoDictionaryKey: UPennConstants.RootURL as String) as! String
    
    public static var LoginURL = Bundle.main.object(forInfoDictionaryKey: UPennConstants.LoginURL as String) as! String
}
