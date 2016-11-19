//
//  TextField.swift
//  TagListViewDemo
//
//  Created by Alexander Givens on 11/18/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    var deleteBackwardHandler: (() -> Void)?

    override func deleteBackward() {
        if let fieldText = text where fieldText.isEmpty {
            deleteBackwardHandler?()
        }
        super.deleteBackward()
    }

}
