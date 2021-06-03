//
//  UPennLoginNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation

public protocol UPennLoginNetworkingRequestable : UPennNetworkRequestable {
    
    
}

extension UPennLoginNetworkingRequestable {
    
    func makeLoginRequest(username: String, password: String, completion: @escaping (UPennRequestCompletion)) {
        
        let parameters: [String:String] = [
            "username" : username,
            "password" : password
        ]
        
        // Make Request for JWT FIXME:
        self.makePOSTRequest(urlStr: urlProvider.userLoginEndpoint, parameters: parameters, encoding: .JSON, completion: completion)
        
//        let jwtRequest = defaultManager.request(self.configuration.loginEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
//        jwtRequest.responseJSON { (response) in
//            self.unwrapResponseForStatusCode(response, completion: completion)
//        }
    }
}

open class UPennLoginNetworkService : UPennLoginNetworkingRequestable {
    
    public var urlProvider: UPennURLProvidable
    
    public init(urlProvider: UPennURLProvidable) {
        self.urlProvider = urlProvider
    }
}
