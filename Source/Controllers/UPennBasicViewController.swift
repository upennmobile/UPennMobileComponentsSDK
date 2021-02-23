//
//  UPennBasicViewController.swift
//  Unable To Scan
//
//  Created by Rashad Abdul-Salam on 7/23/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

open class UPennBasicViewController : UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarSetup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
