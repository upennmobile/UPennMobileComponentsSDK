//
//  UPennImageAssets.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/1/21.
//

import Foundation
import UIKit

public enum UPennImageAssets {
    
    public static var CheckedCheckBox : UIImage {
        return UIImage(named: "checked.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var UnCheckedCheckBox : UIImage {
        return UIImage(named: "un_checked.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var UPennBannerTransparent : UIImage {
        return UIImage(named: "penn_medicine_transparent.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var FaceIDIcon : UIImage {
        return UIImage(named: "faceID_icon.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var TouchIDIcon : UIImage {
        return UIImage(named: "touchID_icon.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var LogoutIcon : UIImage {
        return UIImage(named: "logout_icon.png", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var AccountSelected : UIImage {
        return UIImage(named: "account_selected", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
    
    public static var AccountUnSelected : UIImage {
        return UIImage(named: "account_unselected", in: Bundle.UPennSDKResourcesProvider(), compatibleWith: nil)!
    }
}
