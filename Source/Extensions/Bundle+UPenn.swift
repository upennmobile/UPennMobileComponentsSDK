//
//  Bundle+UPenn.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/28/21.
//

import Foundation

public extension Bundle {
    /**
     User following to fetch an image
     
     let resourceBundle = Bundle.UPennSDKResourcesBundle()
     let image = UIImage(named: "ic_arrow_back", inBundle: resourceBundle, compatibleWithTraitCollection: nil)
     return image
     */
   static func UPennSDKResourcesBundle() -> Bundle? {
    let bundle = Bundle(for: Self.self)
      guard let resourcesBundleUrl = bundle.resourceURL?.appendingPathComponent("UPennMobileComponentsSDK.bundle") else {
         return nil
      }
      return Bundle(url: resourcesBundleUrl)
   }
}
