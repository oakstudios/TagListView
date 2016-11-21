//
//  TextField.swift
//  TagListViewDemo
//
//  Created by Alexander Givens on 11/18/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

class TextField: UITextField, UITextFieldDelegate {
    
    var deleteHandler: ((isEmpty: Bool) -> Void)?
    var editingHandler:((isEditing: Bool) ->Void)?
    
    override func deleteBackward() {
        let isEmpty = text?.isEmpty ?? false
        deleteHandler?(isEmpty: isEmpty)
        super.deleteBackward()
    }
    
    var textWidth: CGFloat {
        let textFont = font ?? UIFont.systemFontOfSize(12.0)
        return (text?.sizeWithAttributes([NSFontAttributeName: textFont]).width ?? 0) + 10.0
    }
    
    override func becomeFirstResponder() -> Bool {
        editingHandler?(isEditing: true)
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        editingHandler?(isEditing: false)
        return true
    }

}
