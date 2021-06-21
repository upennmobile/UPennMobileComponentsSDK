//
//  UPennCenteredButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

open class UPennCenteredButtonCell : UITableViewCell, UPennCellIdentifiable {
    
    @IBOutlet public weak var buttonView : UPennCenteredButtonView!
    
    public func configure(title: String, delegate: UPennCenteredButtonDelegate) {
        self.buttonView.configure(title: title, delegate: delegate)
    }
    
    
}
