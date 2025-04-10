//
//  CartItemTableViewCell.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

protocol CartItemTableViewCellDelegate: AnyObject {
    func addItem(atIndex: Int)
    func removeItem(atIndex: Int)
}

class CartItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellBackView: UIView!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var cartItemCount: Int = 0
    var delegate: CartItemTableViewCellDelegate?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackView.cornerRadius = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func minuButtonAction(_ sender: UIButton) {
        delegate?.addItem(atIndex: index)
        if cartItemCount > 0 {
            cartItemCount -= 1
        }
    }
    
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        delegate?.removeItem(atIndex: index)
        cartItemCount += 1
    }
}
