//
//  UPennMasterCoordinatable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/1/21.
//

import Foundation
import UIKit

public protocol UPennMasterCoordinatable : UPennCoordinator {
    
//    var loginCoordinator : UPennLoginCoordinator {get set}
//    var mainCoordinator : UPennMainCoordinator {get set}
}

extension UPennMasterCoordinatable {
    
//    public func makeParentViewController(_ viewController: UIViewController) {
//        navigationController.addChild(viewController)
//        viewController.view.frame = navigationController.view.bounds
//        navigationController.view.addSubview(viewController.view)
//        viewController.didMove(toParent: navigationController)
//    }
//    
//    public func swapParentViewController(fromVC: UIViewController?, toVC: UIViewController) {
//        guard let fromVC = fromVC else
//        {
//            // If no 'fromVC' assume it's the 1st app launch so no previous child VC was set, so swap to loginNav
//            self.makeParentViewController(toVC)
//            return
//        }
//        navigationController.addChild(toVC)
//        toVC.view.frame = navigationController.view.bounds
//        navigationController.view.addSubview(toVC.view)
//        toVC.didMove(toParent: navigationController)
//        fromVC.willMove(toParent: nil)
//        fromVC.view.removeFromSuperview()
//        fromVC.removeFromParent()
//    }
}
