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

open class UPennLoginNetworkService : UPennLoginNetworkingRequestable {
    
    public var urlProvider: UPennURLProvidable
    
    public init(urlProvider: UPennURLProvidable) {
        self.urlProvider = urlProvider
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
            "password" : password
        ]
        
        self.makePOSTRequest(urlStr: urlProvider.userLoginEndpoint, parameters: parameters, encoding: .JSON, completion: completion)
    }
}
