//
//  CustomTextField.swift
//  UserDefaut
//
//  Created by Dang Trung Hieu on 8/12/19.
//  Copyright © 2019 Dang Trung Hieu. All rights reserved.
//

import UIKit

class CustomeTextField: UITextField {
    let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
