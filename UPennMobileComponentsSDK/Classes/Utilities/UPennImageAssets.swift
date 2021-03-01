//
//  UPennImageAssets.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/1/21.
//

import Foundation
import UIKit

public struct UPennImageAssets {
    
    public static var CheckedCheckBox : UIImage? {
        return UIImage(named: "checked.png", in: Bundle.UPennSDKResourcesBundle(), compatibleWith: nil)
    }
    
    public static var UnCheckedCheckBox : UIImage? {
        return UIImage(named: "un_checked.png", in: Bundle.UPennSDKResourcesBundle(), compatibleWith: nil)
    }
    
    public static var UPennBannerTransparent : UIImage? {
        return UIImage(named: "penn_medicine_transparent.png", in: Bundle.UPennSDKResourcesBundle(), compatibleWith: nil)
    }
}
