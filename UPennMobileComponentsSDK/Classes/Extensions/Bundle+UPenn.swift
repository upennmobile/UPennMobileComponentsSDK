//
//  Bundle+UPenn.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/28/21.
//

import Foundation

public extension Bundle {
    
    enum Context : String {
        case Main = "upenn_main"
        case SDK = "upenn_sdk"
    }
    /**
     User following to fetch an image
     
     let resourceBundle = Bundle.UPennSDKResourcesBundle()
     let image = UIImage(named: "ic_arrow_back", inBundle: resourceBundle, compatibleWithTraitCollection: nil)
     return image
     */
   static func UPennSDKResourcesProvider() -> Bundle? {
    
    let bundle = Bundle(for: UPennAuthenticationService.self)
    guard let resourcesBundleUrl = bundle.path(forResource: "UPennMobileComponentsSDK", ofType: "bundle") else {
         return nil
      }
      return Bundle(url: URL(fileURLWithPath: resourcesBundleUrl))
   }
}
