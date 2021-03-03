//
//  UPennNetworkRequestable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation

protocol UPennNetworkRequestable {
    
    var statusCodeError : String { get }
    var genericRequestError : String { get}
    var networkError : String { get }
}

extension UPennNetworkRequestable {
    
    var statusCodeError : String { return "Cannot get a Status Code for your Request. Please try again." }
    var genericRequestError : String { return "Something went wrong with your Request. Please try again." }
    var networkError : String { return "Lost connection to PennMedicine WiFi." }
}
