//
//  UPennCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/27/21.
//

import Foundation
import UIKit

public protocol UPennCoordinator {
    var childCoordinators: [UPennCoordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
