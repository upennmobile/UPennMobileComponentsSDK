//
//  UPennSettingsViewModelled.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/6/21.
//

import Foundation
import UIKit

public protocol UPennTableViewSectionsHeaderAndFooterDelegate {
    func numberOfSections(_ tableView: UITableView) -> Int
    func titleForHeaderInSection(_ section: Int) -> String
    func heightForHeaderInSection(_ section: Int) -> CGFloat
    func heightForFooterInSection(_ section: Int) -> CGFloat
    func viewForFooterInSection(_ section: Int, for tableView: UITableView) -> UIView
}

public protocol UPennTableViewSelectionDelegate {
    
    func tableView(_ tableView: UITableView, selectedIndexPath: IndexPath)
}

public protocol UPennSettingsViewModelled : UPennTableViewDelegate, UPennTableViewSelectionDelegate, UPennTableViewSectionsHeaderAndFooterDelegate {
    
}

public protocol UPennSettingsInterface : UPennLogoutBiometricsDelegate {
    func presentWithDraw()
}

public protocol UPennCountable {
    static var Count: Int { get }
}
