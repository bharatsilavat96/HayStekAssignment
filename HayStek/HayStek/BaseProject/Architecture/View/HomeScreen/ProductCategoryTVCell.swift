//
//  ProductCategoryTVCell.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class ProductCategoryTVCell: UITableViewCell {
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    private var uniqueCategories: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    func setupCellUI() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.register(UINib(nibName: "ProductCatagoryCVCell", bundle: nil), forCellWithReuseIdentifier: "ProductCatagoryCVCell")

        
    }
    
    func reloadData(withProducts: [ProductResponse]) {
        let allCategories = withProducts.map { $0.category }
        self.uniqueCategories = Array(Set(allCategories))
        
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
}

extension ProductCategoryTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.uniqueCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCatagoryCVCell", for: indexPath) as? ProductCatagoryCVCell
        cell?.productNameLabel.text = self.uniqueCategories[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension ProductCategoryTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
}
