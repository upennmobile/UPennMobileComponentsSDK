//
//  UPennApplicationControls.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/12/21.
//

import Foundation
import UIKit

open class UPennApplicationControls {
    
    public static func OpenSettings() {
        let url = URL(string: UIApplication.openSettingsURLString)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    public static func CloseApp() {
        UIControl().sendAction(#selector(NSXPCConnection.suspend),
                               to: UIApplication.shared, for: nil)
    }
    
    public static func OpenURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
