//
//  FirebaseUtils.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 18/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    var categories: Query {
        return collection("categories").order(by: "timeStamp")
    }
}
