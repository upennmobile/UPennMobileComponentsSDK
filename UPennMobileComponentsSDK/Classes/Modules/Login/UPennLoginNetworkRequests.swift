//
//  UPennLoginNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation

public class UPennLoginNetworkingService : UPennBaseNetworkingService {
    
    func makeLoginRequest(username: String, password: String, completion: @escaping (UPRequestCompletion)) {
        
        let parameters: [String:String] = [
            "username" : username,
            "password" : password
        ]
        
        // Make Request for JWT FIXME:
        self.makePOSTRequest(parameters: parameters, urlStr: urlProvider.userLoginEndpoint, completion: completion)
        
//        let jwtRequest = defaultManager.request(self.configuration.loginEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
//        jwtRequest.responseJSON { (response) in
//            self.unwrapResponseForStatusCode(response, completion: completion)
//        }
    }
}

extension UPennLoginNetworkingService { }
