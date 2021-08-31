//
//  UPennBasicTableViewCell.swift
//  Unable To Scan
//
//  Created by Rashad Abdul-Salam on 6/29/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

open class UPennBasicTableViewCell : UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
