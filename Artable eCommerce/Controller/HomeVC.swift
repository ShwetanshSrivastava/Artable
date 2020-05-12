//
//  ViewController.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 15/02/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var logInOutBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    print(error)
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser, !user.isAnonymous{
            // logged in
            logInOutBtn.title = "Logout"
        } else {
            logInOutBtn.title = "Login"
        }
    }

    func presentLoginController() {
        
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        controller.modalPresentationStyle = .fullScreen
        present(controller,animated: true,completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func logInOutBtn(_ sender: UIBarButtonItem) {
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
                    }
                    self.presentLoginController()
                }
            } catch {
                self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
            }
        }
    }
    
}

