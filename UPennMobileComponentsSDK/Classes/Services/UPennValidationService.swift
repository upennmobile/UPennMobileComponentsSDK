//
//  UPennValidationService.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/12/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

public class UPennValidationService {
    
    public var textFields = Array<UITextField>()
    
    public var allFieldsAreValid: Bool {
        for field in self.textFields {
            guard let text = field.text else { return false }
            if text.isEmpty {
                return false
            }
        }
        return true
    }
    
    public init(textFields: Array<UITextField> = [UITextField]()) {
        if textFields.count > 0 {
            self.textFields = textFields
            setTextFieldTags()
        }
    }
    
    public func setTextFieldTags() {
        var tagCount = 0
        for field in self.textFields {
            field.tag = tagCount
            tagCount += 1
        }
    }
    
    public func addTextFieldAndTag(_ textField: inout UITextField, _ tag: Int) {
        textField.tag = tag
        self.textFields.append(textField)
    }
    
    public func resetTextFields() {
        for field in self.textFields {
            field.text = ""
        }
    }
}
