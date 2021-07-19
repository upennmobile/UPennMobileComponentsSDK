//
//  UPennAutoLogoutCell.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/18/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

class UPennAutoLogoutCell : UPennBasicCell {
    
    
    @IBOutlet weak var timeoutControl: UPennBasicSegmentControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeoutControl.selectedSegmentIndex = UPennTimerUIApplication.TimeoutIndex
    }
    
    @IBAction func pressedTimeoutControl(_ sender: UISegmentedControl) {
        UPennTimerUIApplication.updateTimeoutInterval(index: self.timeoutControl.selectedSegmentIndex)
    }
}
