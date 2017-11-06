//
//  NoCopyPasteUITextField.swift
//  BillLegalApp
//
//  Created by Apple on 18/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import UIKit

class NoCopyPasteUITextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)){
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}
