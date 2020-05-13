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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - variables
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category = Category(name: "Nature", id: "asas", imgUrl: "https://images.unsplash.com/photo-1543183344-acd290d5142e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", isActive: true, timestamp: Timestamp())
        
        categories.append(category)
        categories.append(category)
        categories.append(category)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
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

//MARK: - Delegates

extension HomeVC: UICollectionViewDelegate {
    
}

//MARK: - Datasources

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = ( width - 70 ) / 3
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
