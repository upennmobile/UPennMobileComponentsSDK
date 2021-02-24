//
//  UPennLoginServiceDelegate.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 4/23/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation

/// Interface for an object to be able to respond to Login-related events
public protocol UPennLoginServiceDelegate {
    func didSuccessfullyLoginUser()
    func didReturnAutoFillCredentials(username: String, password: String)
    func didFailToLoginUser(errorStr: String)
}
