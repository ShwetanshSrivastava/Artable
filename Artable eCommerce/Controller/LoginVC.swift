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
    
    //MARK: - Variables
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        // Do any additional setup after loading the view.
    }
    

    //MARK: - IB Actions
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailTxt?.text, email.isNotEmpty,
            let password = passwordTxt?.text, password.isNotEmpty else {
                self.alert(title: "Error", message: "Please enter the data", options: "Ok", completion: nil)
                return
        }
        activityIndicator.startAnimating()
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
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - Target Actions
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            guard viewTranslation.y > 0 else { return }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
}
