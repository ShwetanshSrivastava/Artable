//
//  RegisterVC.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 10/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var confirmImg: UIImageView!
    @IBOutlet weak var passCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    //MARK: - IB Actions
    @IBAction func registerClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        guard let email = emailTxt.text, email.isValidEmail,
            let username = usernameTxt.text, username.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else {
                self.activityIndicator.stopAnimating()
                self.alert(title: "Empty fields", message: "Please fill out all fields", options: "Ok", completion: nil)
                return
        }
        
        guard let confirmPass = confirmPasswordTxt.text, confirmPass == password else {
            self.alert(title: "Error", message: "Passwords do not match", options: "ok", completion: nil)
            return
        }
        
        guard let authUser = Auth.auth().currentUser else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        authUser.link(with: credential) { (authResult, error) in
            guard error == nil else {
                let error = error
                self.activityIndicator.stopAnimating()
                self.alert(title: "Invalid Submission", message: error?.localizedDescription ?? "Invalid Format", options: "Ok",completion: nil)
                return
            }
            self.activityIndicator.stopAnimating()
            self.alert(title: "User Registered", message: "You are successfully registered", options: "Ok") { (option) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: - Target functions
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let passText = passwordTxt.text else { return }
        
        if confirmPasswordTxt == textField {
            confirmImg.isHidden = false
            passCheck.isHidden = false
        } else {
            if passText.isEmpty {
                passCheck.isHidden = true
                confirmImg.isHidden = true
                confirmPasswordTxt.text = ""
            }
        }
        if passwordTxt.text == confirmPasswordTxt.text {
            passCheck.image = UIImage(named: AppImages.GreenCheck)
            confirmImg.image = UIImage(named: AppImages.GreenCheck)

        } else {
            passCheck.image = UIImage(named: AppImages.RedCheck)
            confirmImg.image = UIImage(named: AppImages.RedCheck)
        }
    }
    
}
