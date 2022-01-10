//
//  UPennCenteredButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

protocol UPennCenteredButtonConfigureInterface {
    func configure(with decorator: UPennCenteredButtonDecorator)
}

open class UPennCenteredButtonCell : UITableViewCell, UPennCellIdentifiable, UPennCenteredButtonConfigureInterface {
    
    @IBOutlet public weak var buttonView : UPennCenteredButtonView!
    
    public func configure(with decorator: UPennCenteredButtonDecorator) {
        self.buttonView.configure(with: decorator)
    }
    
    
}
