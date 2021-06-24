//
//  UPennLoginViewModelled.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

/// Custom SDK delegate that mirrors base UITableViewDelegate methods
public protocol UPennTableViewDelegate {
    func rowsInSection(_ section: Int) -> Int
    func getCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell
}

/// Interface for constructing a LoginViewModel to construct TableView cells, handle text changes and Auto-fill updates
public protocol UPennLoginViewModelled : UPennTableViewDelegate {
    
    func textChangedUpdateView(textField: UITextField, completion: @escaping (_ username: String?, _ password: String?, _ indexPaths: Array<IndexPath>)->Void)
    func autofillUpdateSections() -> Array<IndexPath>
}

/// Delegate method primarily for a LoginViewModel to inform a LoginVC to initiate login
public protocol UPennLoginViewModelDelegate {
    func login()
}
