//
//  UPennDeviceService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 10/19/21.
//

import Foundation

struct UPennDeviceService {
    static func copyToClipboard(_ text: String, completion: ((_ copied: Bool)->Void)?=nil) {
        UIPasteboard.general.string = text
        let copied = UIPasteboard.general.string != nil
        if let _completion = completion {
            _completion(copied)
        }
    }
    
    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    static func openAsURL(_ urlString: String, completion: ((_ errorMessage: String?)->Void)) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            completion(nil)
            return
        }
        completion("Could not call \(urlString). Please try again")
    }
}
