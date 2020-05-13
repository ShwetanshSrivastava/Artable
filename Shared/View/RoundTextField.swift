//
//  RoundTextField.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 10/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundTextField: UITextField {
    
    @IBInspectable
    var placeHolderTextColor: UIColor? {
        set {
            let placeholderText = self.placeholder != nil ? self.placeholder! : ""
            attributedPlaceholder = NSAttributedString(string:placeholderText, attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
        get{
            return self.placeHolderTextColor
        }
    }
    
    @IBInspectable
    override var cornerRadius: CGFloat {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
  
    @IBInspectable
    var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
        
    }
}
