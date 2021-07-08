//
//  UPennLogoutCell.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/18/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

class UPennLogoutCell : UPennBasicCell, UPennLeftImageButtonConfigureInterface {
    
    @IBOutlet weak var buttonView: UPennLeftImageButtonView!
    
    func configure(title: String, styles: UPennButtonStyler, delegate: UPennLeftImageButtonDelegate) {
        self.buttonView.configure(title: title, styles: styles, delegate: delegate)
    }
    
}
