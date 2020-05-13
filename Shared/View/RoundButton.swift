//
//  RoundButton.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 10/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton: UIButton {
    // MARK: Properties
    @IBInspectable
    override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }

    // MARK: - Lifecycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Layout View
    func layoutView() {
        // set the shadow of the view's layer
        // layer.backgroundColor = UIColor.clear.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}
