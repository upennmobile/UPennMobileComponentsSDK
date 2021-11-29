//
//  UPennContactService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 10/19/21.
//

import Foundation

public struct UPennContactService {
    
    public static func CallPhoneNumber(_ number: String, completion: ((_ errorMessage: String?)->Void)) {
        // TODO: Fix when done testing!!!
//        print("Calling \(number)")
        UPennDeviceService.openAsURL("telprompt:\(number)") { (errMessage) in
            completion(errMessage)
        }
    }
}
