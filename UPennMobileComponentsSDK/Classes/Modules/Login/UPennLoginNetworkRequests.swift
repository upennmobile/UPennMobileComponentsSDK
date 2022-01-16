//
//  UPennLoginNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation

public protocol UPennLoginNetworkingRequestable : UPennNetworkRequestable {
    
    func makeLoginRequest(username: String, password: String, completion: @escaping (UPennRequestCompletion))
}

open class UPennLoginNetworkService : UPennBaseNetworkingService, UPennLoginNetworkingRequestable {
    
    convenience init() {
        self.init(appendedURL: UPennApplicationSettings.LoginURL)
    }
    
    /**
     Overridable method for constructing a custom login request
     - parameters:
        - username: UPenn network login
        - password: UPenn network password
     */
    open func makeLoginRequest(username: String, password: String, completion: @escaping (UPennRequestCompletion)) {
        
        let parameters: [String:String] = [
            "username" : username,
            "password" : password,
            "grant_type" : "password"
        ]
        
        self.makeBasePOSTRequest(parameters: parameters, encoding: .URL, completion: completion)
    }
}
