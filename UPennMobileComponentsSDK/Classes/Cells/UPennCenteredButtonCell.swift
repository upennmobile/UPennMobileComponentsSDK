//
//  UPennCenteredButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

protocol UPennCenteredButtonConfigureInterface {
    func configure(title: String, delegate: UPennCenteredButtonDelegate, enabled: Bool)
}

open class UPennCenteredButtonCell : UITableViewCell, UPennCellIdentifiable, UPennCenteredButtonConfigureInterface {
    
    @IBOutlet public weak var buttonView : UPennCenteredButtonView!
    
    public func configure(title: String, delegate: UPennCenteredButtonDelegate, enabled: Bool) {
        self.buttonView.configure(title: title, delegate: delegate, enabled: enabled)
    }
    
    
}
