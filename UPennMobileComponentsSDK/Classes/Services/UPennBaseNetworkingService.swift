//
//  UPennBaseNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/6/21.
//

import Foundation

open class UPennBaseNetworkingService : UPennNetworkRequestable {
    
    open var urlProvider: UPennURLProvidable
        
    open var headers : UPennHeadersDict {
        if let token = UPennAuthenticationService.AuthToken {
            return [ "Authorization" : "Bearer " + token ]
        }
        return [ "Authorization" : "Bearer " + "" ]
    }
    
    open var urlEndpoint: String {
        return urlProvider.rootURL+urlProvider.appendedURL
    }
        
    public init(appendedURL: String?=nil) {
        if let appended = appendedURL {
            self.urlProvider = UPennURLProvider(rootURL: UPennApplicationSettings.RootURL, appendedURL: appended)
        } else {
            self.urlProvider = UPennURLProvider(rootURL: UPennApplicationSettings.RootURL, appendedURL: "")
        }
    }
    
    open func makeBasePOSTRequest(urlStr: String?=nil, parameters: UPennParametersDict?=nil, encoding: UPennRequestEncoding.EncodingType, completion: @escaping (UPennRequestCompletion)) {
        if let urlStr = urlStr {
            self.makePOSTRequest(urlStr: self.urlEndpoint+urlStr, parameters: parameters, headers: self.headers, encoding: encoding, completion: completion)
        } else {
            self.makePOSTRequest(urlStr: self.urlEndpoint, parameters: parameters, headers: self.headers, encoding: encoding, completion: completion)
        }
    }
    
    open func makeBaseGETRequest(urlStr: String?=nil, parameters: UPennParametersDict?=nil, encoding: UPennRequestEncoding.EncodingType, completion: @escaping (UPennRequestCompletion)) {
        if let urlStr = urlStr {
            self.makeGETRequest(urlStr: self.urlEndpoint+urlStr, parameters: parameters, headers: self.headers, encoding: encoding, completion: completion)
        } else {
            self.makeGETRequest(urlStr: self.urlEndpoint, parameters: parameters, headers: self.headers, encoding: encoding, completion: completion)
        }
    }
    
    
    
}
