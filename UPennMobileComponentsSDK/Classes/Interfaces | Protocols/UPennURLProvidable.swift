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

open class UPennURLProvider : UPennURLProvidable {
    open var rootURL: String
    
    open var userLoginEndpoint: String
    
    public init(rootURL: String, loginEndpoint: String) {
        self.rootURL = rootURL
        self.userLoginEndpoint = loginEndpoint
    }
}
