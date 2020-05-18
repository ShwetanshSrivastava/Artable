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
    var selectedCategory: Category!
    var db: Firestore!
    var listener: ListenerRegistration!
    
    //MARK: - LifeCycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        setupCollectionView()
        setupInitialAnonymousUser()
        setupNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        setCategoriesListener()
        if let user = Auth.auth().currentUser, !user.isAnonymous{
            // logged in
            logInOutBtn.title = "Logout"
        } else {
            logInOutBtn.title = "Login"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        collectionView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToProducts {
            if let destinationVC = segue.destination as? ProductsVC {
                destinationVC.category = selectedCategory
            }
        }
    }
    
    //MARK: - Methods
    
    func presentLoginController() {
        
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        controller.modalPresentationStyle = .fullScreen
        present(controller,animated: true,completion: nil)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
    }
    
    func setupInitialAnonymousUser() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
                }
            }
        }
    }
    func setupNavigationBar() {
        guard let font = UIFont(name: "futura", size: 26) else { return }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
    }
    
}

//MARK: - Delegates

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.ToProducts, sender: self)
    }
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
        let cellHeight = cellWidth * 1.3
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

//MARK: - Firebase Extension

extension HomeVC {
    
    func setCategoriesListener() {
        listener = db.categories.addSnapshotListener({ (snap, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription, options: "Ok", completion: nil)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category(data: data)
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemove(change: change)
                }
            })
        })
    }
    
    func onDocumentAdded(change: DocumentChange, category: Category) {
         let newIndex = Int(change.newIndex)
         categories.insert(category, at: newIndex)
         collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
     }
     
     func onDocumentModified(change: DocumentChange, category: Category) {
         if change.newIndex == change.oldIndex {
             let index = Int(change.newIndex)
             categories[index] = category
             collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
         } else {
             let oldIndex = Int(change.oldIndex)
             let newIndex = Int(change.newIndex)
             categories.remove(at: oldIndex)
             categories.insert(category, at: newIndex)
             collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
         }
     }
     
     func onDocumentRemove(change: DocumentChange) {
         let oldIndex = Int(change.oldIndex)
         categories.remove(at: oldIndex)
         collectionView.deleteItems(at: [IndexPath(item: oldIndex , section: 0)])
     }
}



//MARK: - Prior test code -

extension HomeVC {
    
    private func fetchDocument() {
        let docRef = db.collection("categories").document("VmQfeT5reNpv2nOnXIag")
        docRef.getDocument { (snap, error) in
            guard let data = snap?.data() else { return }

            let newCategory = Category(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        }
    }

    private func fetchDocuments() {
        let collectionRef = db.collection("categories")
        listener = collectionRef.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else { return }
            self.categories.removeAll()
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
    }

    private func fetchCollection() {
        let collectionRef = db.collection("categories")

            collectionRef.getDocuments { (snap, error) in
            guard let documents = snap?.documents else { return }
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
    }
}
