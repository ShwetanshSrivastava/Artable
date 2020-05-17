//
//  ProductsVC.swift
//  Artable eCommerce
//
//  Created by Shwetansh Srivastava on 14/05/20.
//  Copyright © 2020 Shwetansh Srivastava. All rights reserved.
//

import UIKit
import FirebaseFirestore
class ProductsVC: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - variables
    var products = [Product]()
    var category: Category!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let product = Product(name: "Guuci", id: "sdsd", category: "Nature", price: 99.99, productDescriptino: "nice", imgUrl: "https://images.unsplash.com/photo-1565612390655-6b31416922db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80", timestamp: Timestamp(), stock: 0, favourite: false)
        products.append(product)
        products.append(product)

        products.append(product)
        products.append(product)
        products.append(product)
        products.append(product)
        products.append(product)

        collectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.ProductCell)
        
        // Do any additional setup after loading the view.
    }

}



//MARK: - CollectionView Delegates

extension ProductsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}

//MARK: - CollectionView Datasource

extension ProductsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureProducts(product: products[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = ( width - 20 ) / 2
        let cellHeight = cellWidth * 1.4
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
