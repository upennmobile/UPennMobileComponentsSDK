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
    var childViewController : UIViewController? { get }
    func start()
}

public extension UPennCoordinator {
    
    var presentedViewController : UIViewController? {
        return self.navigationController.visibleViewController
    }
    
    func getChildCoordinator<T: UPennCoordinator>(type: T.Type) -> T? {
        return childCoordinators.compactMap({ $0 as? T }).first
    }
    
}
