//
//  ForgotPasswordVC.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 12/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: RoundTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetClicked(_ sender: Any) {
        
        guard let email = emailTxt.text,
            email.isNotEmpty else {
                self.alert(title: "Error", message: "Please enter the email.", options: "Ok", completion: nil)
                return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
                return
            }
            self.alert(title: "Success", message: "Please check your email.", options: "Ok") { (option) in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
