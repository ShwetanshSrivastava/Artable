//
//  Product.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 14/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id: String
    var category: String
    var price: Double
    var productDescriptino: String
    var imgUrl: String
    var timestamp: Timestamp
    var stock: Int
    var favourite: Bool
}
