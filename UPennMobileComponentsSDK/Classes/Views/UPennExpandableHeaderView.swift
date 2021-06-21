//
//  UPennExpandableHeaderView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/17/21.
//

import Foundation
import UIKit

protocol UPennHeaderHeightCallable {
}

extension UPennHeaderHeightCallable {
    static var Height : CGFloat { return 40 }
}

protocol UPennExpandableHeaderViewDelegate {
    func toggledExpandButton(expandHash: [Int:Bool])
}

class UPennExpandableHeaderView : UITableViewHeaderFooterView, UPennHeaderHeightCallable {
    
    static var Identifier : String {
        return String(describing: self)
    }
    
    @IBOutlet weak var groupTitle: SectionHeaderTitleLabel!
    @IBOutlet weak var expandToggleButton: UIButton! {
        didSet {
            self.expandToggleButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
            self.expandToggleButton.tintColor = .white
        }
    }
    
    var sectionIndex: Int!
    var delegate: UPennExpandableHeaderViewDelegate?
    private var expandHash = [Int:Bool]()
    private var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    @IBAction func pressedExpandToggleButton(_ sender: UIButton) {
        self.toggleExpandButton(isExpanded: self.expandHash[self.section] ?? false)
        self.delegate?.toggledExpandButton(expandHash: self.expandHash)
    }
    
    func configure(_ title: String, _ section: Int, _ expandHash: [Int:Bool], _ delegate: UPennExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.groupTitle.text = title
        self.section = section
        self.expandHash = expandHash
//        self.toggleExpandButton(isExpanded: self.expandHash[section] ?? false)
    }
}

private extension UPennExpandableHeaderView {
    
    func xibSetup() {
        backgroundView = UIView(frame: bounds)
        self.expandToggleButton.titleLabel?.textColor = UIColor.white
        self.expandToggleButton.titleLabel?.font = UIFont.helveticaBold(size: 15.0)
        self.backgroundView?.backgroundColor = UIColor.upennMediumBlue
//        self.groupTitle.textColor = UIColor.white
//        self.groupTitle.font = UIFont.helveticaBold(size: 13.0)
    }
    
    func toggleExpandButton(isExpanded: Bool) {
        if isExpanded {
            self.closeDropdown()
            
        } else {
            self.openDropdown()
            
        }
        self.delegate?.toggledExpandButton(expandHash: self.expandHash)
    }
    
    func closeDropdown() {
        self.expandHash[section] = false
        UIView.animate(withDuration: 2.0) { () -> Void in
            self.expandToggleButton.transform = CGAffineTransform.identity
        }
    }
    
    func openDropdown() {
        self.expandHash[section] = true
        UIView.animate(withDuration: 2.0) { () -> Void in
          self.expandToggleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
}

