//
//  UPennURLProvidable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/6/21.
//

import Foundation
import UIKit

public protocol UPennURLProvidable {
    var rootURL : String { get set }
    var userLoginEndpoint : String { get set }
}

extension UPennURLProvidable {
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

struct UPennURLProvider : UPennURLProvidable {
    var rootURL: String
    
    var userLoginEndpoint: String
    
    init(rootURL: String, loginEndpoint: String) {
        self.rootURL = rootURL
        self.userLoginEndpoint = loginEndpoint
    }
}
