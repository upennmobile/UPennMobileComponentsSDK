//
//  UPennLeftImageButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

public struct UPennButtonStyles {
    
    public var title: String
    public var selectedImage: UIImage?
    public var deselectedImage: UIImage?
    public var isSelected: Bool
    
    public init(title: String, selectedImage: UIImage? = nil, deselectedImage: UIImage? = nil, isSelected: Bool=false) {
        self.title = title
        self.selectedImage = selectedImage
        self.deselectedImage = deselectedImage
        self.isSelected = isSelected
    }
}

public protocol UPennLeftImageButtonConfigureInterface {
    
    func configure(styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate)
    
}

public protocol UPennLeftImageButtonDelegate : AnyObject {
    func pressedLeftImageButton(_ button: UIButton)
}


open class UPennLeftImageButtonView : UPennNibView, UPennLeftImageButtonConfigureInterface {
    
    
    @IBOutlet open weak var button: PrimaryCTAButtonText!
    
    open weak var delegate: UPennLeftImageButtonDelegate?
    
    public func configure(styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate) {
        self.delegate = delegate
        self.button.setTitle(styles.title, for: .normal)
        self.button.setImage(styles.deselectedImage, for: .normal)
        self.button.setImage(styles.selectedImage, for: .selected)
        self.button.isSelected = styles.isSelected
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .leading
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 0, right: -100)
        button.sizeToFit()
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        self.button.isSelected = !self.button.isSelected
        self.delegate?.pressedLeftImageButton(sender)
    }
    
    
}

