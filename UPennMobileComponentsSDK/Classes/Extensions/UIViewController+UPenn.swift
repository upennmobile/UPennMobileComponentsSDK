//
//  UIViewController+UPenn.swift
//  Phone Book
//
//  Created by Rashad Abdul-Salam on 10/24/17.
//  Copyright © 2017 UPenn. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    @objc func navBarSetup() {
        // Set UPenn Deep Blue NavigationBar & white navbar text
        self.navigationController?.navigationBar.isTranslucent = false
        
        // iOS 15 fix
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.upennDeepBlue
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.upennDeepBlue
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        }
    }
    
    @objc func navBarLightSetup() {
        // Set UPenn Deep Blue NavigationBar & white navbar text
        self.navigationController?.navigationBar.barTintColor = UIColor.upennRlyLightGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.upennBlack]
        self.navigationController?.navigationBar.tintColor = UIColor.upennDeepBlue
    }
    
    @objc func reloadView() {
        self.popToNavRoot()
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func popToNavRoot(_ delay: Double=0.0) {
        self.navigationController?.popToRoot(delay)
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
