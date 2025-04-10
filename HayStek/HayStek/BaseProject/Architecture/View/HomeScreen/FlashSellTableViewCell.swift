//
//  FlashSellTableViewCell.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class FlashSellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var flashCellCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    private func setupCellUI() {
        flashCellCollectionView.delegate = self
        flashCellCollectionView.dataSource = self
        flashCellCollectionView.allowsMultipleSelection = false
        flashCellCollectionView.register(UINib(nibName: "FlashSellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FlashSellCollectionViewCell")
    }
    
    func reloadData(withProducts products: [ProductResponse]) {
        // Set your UI / collectionView / data here
    }
}


extension FlashSellTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashSellCollectionViewCell", for: indexPath) as? FlashSellCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
}

extension FlashSellTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let sectionInset = layout.sectionInset
        let spacing = layout.minimumInteritemSpacing
        
        let totalSpacing = sectionInset.left + sectionInset.right + spacing
        let itemWidth = (collectionView.bounds.width - totalSpacing) / 2
        let itemHeight = itemWidth + 60
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
