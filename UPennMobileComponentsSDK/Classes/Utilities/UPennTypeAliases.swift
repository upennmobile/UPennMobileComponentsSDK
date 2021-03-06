//
//  UPennTypeAliases.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/5/21.
//

import Foundation

/**
 Completion block representing data returned from network request
 - parameters:
     - responseJSON: optional response object returned from request
     - errorString: optional error String returned from request
     - delete: Bool indicating the request is a deletion type
 */
typealias UPRequestCompletion = (_ responseJSON: Any?, _ errorString: String?)->Void
typealias UPResponseObjArray = Array<Dictionary<String,Any>>
typealias UPStringDict = Dictionary<String,Any>
