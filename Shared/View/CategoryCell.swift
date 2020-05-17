//
//  CategoryCell.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 12/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var catName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        catImg.layer.cornerRadius = 5
    }

    func configureCell(category: Category) {
        catName.text = category.name
        if let url = URL(string: category.imgUrl) {

            catImg.kf.indicatorType = .activity
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            catImg.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: options)

        }
    }
}
