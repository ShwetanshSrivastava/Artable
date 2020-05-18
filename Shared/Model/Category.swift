//
//  Category.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 12/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timestamp: Timestamp
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timestamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
