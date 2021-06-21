//
//  UPennBasicCell.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/18/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

open class UPennBasicCell : UITableViewCell, UPennCellIdentifiable {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
