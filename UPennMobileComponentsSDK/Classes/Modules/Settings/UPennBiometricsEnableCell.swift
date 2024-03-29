//
//  UPennBiometricsEnableCell.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/18/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

class UPennBiometricsEnableCell : UPennBasicCell, UPennImageLabelSwitchConfigureInterface {
    
    @IBOutlet weak var biometricsImage: UIImageView!
    @IBOutlet weak var biometricsToggleLabel: UPennLabel!
    @IBOutlet weak var biometricsSwitch: UISwitch!
    
    
    @IBOutlet weak var imageLabelSwitchView: UPennImageLabelSwitchView!
    
    
    var biometricsDelegate: UPennBiometricsToggleDelegate?
    
    @IBAction func toggledBiometrics(_ sender: UISwitch) {
        self.biometricsDelegate?.toggledBiometrics(self.biometricsSwitch.isOn)
    }
    
    func configure(_ decorator: UPennImageLabelSwitchControlDecorated) {
        self.imageLabelSwitchView.configure(decorator)
    }
    
//    func configure(with delegate:
//        UPennBiometricsToggleDelegate, biometricsService: UPennBiometricsAuthenticationInterface ) {
//        self.biometricsToggleLabel.text  = biometricsService.toggleTitleText
//        self.biometricsDelegate          = delegate
//        self.biometricsSwitch.isEnabled  = biometricsService.biometricsAvailable
//        self.biometricsSwitch.isSelected = biometricsService.biometricsEnabled
//        self.biometricsImage.image       = biometricsService.biometricsImage
//        self.biometricsSwitch.setOn(biometricsService.biometricsEnabled, animated: false)
//    }
}
