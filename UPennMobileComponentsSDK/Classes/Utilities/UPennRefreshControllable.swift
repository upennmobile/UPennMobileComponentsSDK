//
//  UPennRefreshControllable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/17/21.
//

import Foundation
import UIKit

/// Protocol to give objects with UITableViews pull-to-refresh capability
@objc protocol UPennRefreshControllable : AnyObject {
    
    var refreshControl : UIRefreshControl! { get set }
    var refreshTableView : UITableView { get }
    @objc func refreshCallback()
}

extension UPennRefreshControllable {
    
    func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshCallback), for: .valueChanged)
        self.refreshControl.tintColor = .upennMediumBlue
    }
}
