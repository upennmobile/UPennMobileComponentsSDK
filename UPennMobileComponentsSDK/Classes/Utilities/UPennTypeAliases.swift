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
public typealias UPennRequestCompletion = (_ responseJSON: Any?, _ errorString: String?)->Void
public typealias UPennSuccessCompletion = (_ success: Bool, _ errStr: String?)->Void
public typealias UPennResponseObjArray = Array<Dictionary<String,Any>>
public typealias UPennStringDict = Dictionary<String,Any>
public typealias UPennHeadersDict = Dictionary<String,String>
public typealias UPennParametersDict = Dictionary<String,Any>
