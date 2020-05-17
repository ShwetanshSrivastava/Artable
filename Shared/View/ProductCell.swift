//
//  ProductCell.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 15/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    //MARK: - Variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Actions
    
    @IBAction func addToCartClicked(_ sender: UIButton) {
    }
    @IBAction func addToWishlist(_ sender: UIButton) {
    }
    
    // methods
    
    
    func configureProducts(product: Product) {
        productName.text = product.name
//        productPrice.text = product.price
        if let imgUrl = URL(string: product.imgUrl) {
            productImg.kf.setImage(with: imgUrl)
        }
    }
}
