//
//  UPennNibView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/28/21.
//

import Foundation
import UIKit

class UPennNibView : UIView {
    
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.backgroundColor = UIColor.clear
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        /* NOTE:
        While it might limit the Bundle to retrieve from, may need to update to:
        let bundle = Bundle.UPennSDKResourcesProvider()
        */
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
