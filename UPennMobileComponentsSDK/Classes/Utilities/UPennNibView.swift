//
//  UPennNibView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/28/21.
//

import Foundation
import UIKit

/// Custom UIView
open class UPennNibView : UIView {
    
    open var contentView: UIView!
    open var resourceBundle: Bundle? {
        /*
         1. Get bundle for UPennNibView object
         2. Attempt to get resource URL from SDK
         3. Return the sdkBundle object if from SDK; if not just return original bundle object
         */
        let bundle = Bundle(for: type(of: self))
        guard
            let sdkBundleURL = bundle.url(forResource: "UPennMobileComponentsSDK", withExtension: "bundle"),
            let sdkBundle = Bundle(url: sdkBundleURL)
                else
        {
            return bundle
        }
        return sdkBundle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    open func xibSetup() {
        contentView = loadViewFromNib()
        contentView.backgroundColor = UIColor.clear
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView!)
    }
    
    open func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: self.resourceBundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
