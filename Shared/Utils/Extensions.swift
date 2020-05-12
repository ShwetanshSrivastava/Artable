//
//  Extensions.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 10/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit

//MARK: - String extensions

extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   var isValidPhone: Bool {
      let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

//MARK: - UIViewController extensions

extension UIViewController {
    
    func alert(title: String, message: String, options: String..., completion: ((String) -> Void)? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for option in options {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                if let completion = completion {
                    completion(option)
                }
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
