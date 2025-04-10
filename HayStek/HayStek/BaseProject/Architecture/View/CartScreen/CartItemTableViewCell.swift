//
//  CartItemTableViewCell.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellBackView: UIView!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackView.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func minuButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
    }
}
