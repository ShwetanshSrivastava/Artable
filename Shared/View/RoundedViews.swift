//
//  RoundedViews.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 12/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = AppColors.AppBlue.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
    }
}

class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
