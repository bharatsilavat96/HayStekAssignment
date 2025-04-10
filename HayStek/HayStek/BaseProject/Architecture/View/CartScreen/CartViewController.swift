//
//  CartViewController.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var cartItemTableView: UITableView!
    @IBOutlet weak var cartHeaderView: UIView!
    @IBOutlet weak var addressBackView: UIView!
    
    private var customNavigationBar : CutomerNavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationBar = CutomerNavigationBar.addCustomNavigationBarOnVC(vcToAddNavigation: self, screenName: .CartViewController)
        customNavigationBar?.delegate = self
    }
    
    private func setupUI() {
        cartItemTableView.delegate = self
        cartItemTableView.dataSource = self
        cartItemTableView.showsVerticalScrollIndicator = false
        cartItemTableView.separatorStyle = .none
        
        cartItemTableView.register(UINib(nibName: "CartItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CartItemTableViewCell")
        
        
        cartHeaderView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 16)
        addressBackView.cornerRadius = 16
        
    }
    
    @IBAction func changeAddressButtonAction(_ sender: Any) {
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as? CartItemTableViewCell
        cell?.delegate = self
        cell?.index = indexPath.row
        return cell ?? UITableViewCell()
    }
    
    
}


extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension CartViewController: DelegateCustomNavigationBar {
    func buttonSettingOrBackClicked() {
        print("Setting button clicked")
    }
    
    func buttonOptionOrShareClicked() {
        print("option button clicked")
    }
    
    func buttonLikeClicked() {
        print("like button clicked")
    }
}

extension CartViewController: CartItemTableViewCellDelegate {
    func addItem(atIndex: Int) {
        print("")
    }
    
    func removeItem(atIndex: Int) {
        print("")
    }
}
