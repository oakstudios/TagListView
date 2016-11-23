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
    
    override func deleteBackward() {
        let isEmpty = text?.isEmpty ?? true
        deleteHandler?(isEmpty: isEmpty)
        super.deleteBackward()
    }
    
    var textWidth: CGFloat {
        let tempTextFont = font ?? UIFont.systemFontOfSize(12.0)
        return (text?.sizeWithAttributes([NSFontAttributeName: tempTextFont]).width ?? 0) + 10.0
    }
}
