//
//  UPennBaseNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/6/21.
//

import Foundation

public class UPennBaseNetworkingService : UPennNetworkRequestable {
    
    public var urlProvider: UPennURLProvidable
    
    public init(urlProvider: UPennURLProvidable) {
        self.urlProvider = urlProvider
    }
    
    
    
}
