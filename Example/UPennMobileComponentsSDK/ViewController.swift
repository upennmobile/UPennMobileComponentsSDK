//
//  ViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by rabdulsal on 02/22/2021.
//  Copyright (c) 2021 rabdulsal. All rights reserved.
//

import UIKit
import UPennMobileComponentsSDK

class ViewController: UPennBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarSetup()
        self.popToRoot()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

