//
//  UIViewController+UPenn.swift
//  Phone Book
//
//  Created by Rashad Abdul-Salam on 10/24/17.
//  Copyright © 2017 UPenn. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc open func navBarSetup() {
        // Set UPenn Deep Blue NavigationBar & white navbar text
        self.navigationController?.navigationBar.barTintColor = UIColor.upennDeepBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    @objc open func navBarLightSetup() {
        // Set UPenn Deep Blue NavigationBar & white navbar text
        self.navigationController?.navigationBar.barTintColor = UIColor.upennRlyLightGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.upennBlack]
        self.navigationController?.navigationBar.tintColor = UIColor.upennDeepBlue
    }
    
    @objc open func reloadView() {
        self.popToRoot()
    }
    
    @objc open func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc open func popToRoot(_ delay: Double=0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func makeParentViewController(_ viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func swapParentViewController(fromVC: UIViewController?, toVC: UIViewController) {
        guard let fromVC = fromVC else
        {
            // If no 'fromVC' assume it's the 1st app launch so no previous child VC was set, so swap to loginNav
            self.makeParentViewController(toVC)
            return
        }
        self.makeParentViewController(toVC)
        fromVC.willMove(toParent: nil)
        fromVC.view.removeFromSuperview()
        fromVC.removeFromParent()
    }
}
