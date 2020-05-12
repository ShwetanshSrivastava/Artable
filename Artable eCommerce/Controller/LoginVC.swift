//
//  LoginVC.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 10/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTxt: RoundTextField!
    @IBOutlet weak var passwordTxt: RoundTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IB Actions
    @IBAction func loginBtn(_ sender: Any) {
        activityIndicator.startAnimating()
        guard let email = emailTxt?.text, email.isNotEmpty,
            let password = passwordTxt?.text, password.isNotEmpty else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
            if let error = error {
                self.activityIndicator.stopAnimating()
                self.alert(title: "Invalid", message: error.localizedDescription, options: "Ok", completion: nil)
                return
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func forgotBtn(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc,animated: true,completion: nil)
    }
    
    @IBAction func guestBtn(_ sender: Any) {
        
    }
}
