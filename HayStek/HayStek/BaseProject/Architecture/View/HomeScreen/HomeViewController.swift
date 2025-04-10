//
//  HomeViewController.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeHeaderView: UIView!
    @IBOutlet weak var searchBackView: UIView!
    @IBOutlet weak var flashView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var flashTitleLabel: UILabel!
    
    private var viewModel = HomeViewModel()
    private var responseData: [ProductResponse]?
    private var filteredProducts: [ProductResponse] = []
    private var isSearching = false
    private var customNavigationBar : CutomerNavigationBar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationBar = CutomerNavigationBar.addCustomNavigationBarOnVC(vcToAddNavigation: self, screenName: .HomeViewController)
        customNavigationBar?.delegate = self
    }
    
    
    private func setupUI() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        viewModel.delegate = self
        homeTableView.separatorStyle = .none
        searchBar.delegate = self
        
        homeTableView.register(UINib(nibName: "ProductCategoryTVCell", bundle: nil), forCellReuseIdentifier: "ProductCategoryTVCell")
        homeTableView.register(UINib(nibName: "FlashSellTableViewCell", bundle: nil), forCellReuseIdentifier: "FlashSellTableViewCell")
        
        flashView.roundTopCorners(radius: 12)
        searchBackView.roundTopCorners(radius: 12)
        flashView.applyGradient(
            colors: [UIColor.systemBlue, UIColor.systemTeal],
            startPoint: CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5),
            cornerRadius: 12
        )
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return FlashSaleHeaderView(title: "Categories", showTimer: false)
        } else if section == 1 {
            return FlashSaleHeaderView(title: "Flash Sale", showTimer: true)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return isSearching ? 1 : 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsMultipleSelection = false
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategoryTVCell") as? ProductCategoryTVCell
            let products = responseData ?? []
            cell?.reloadData(withProducts: products)
            return cell ?? UITableViewCell()
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlashSellTableViewCell") as? FlashSellTableViewCell
            if isSearching {
                cell?.reloadData(withProducts: filteredProducts)
            } else {
                let products = responseData ?? []
                cell?.reloadData(withProducts: products)
            }
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        return isSearching ? 400 : 400
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}


extension HomeViewController: HomeViewModelDelegate {
    func didFetchProducts(_ products: [ProductResponse]) {
        responseData = products
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
    
    func didFailToFetchProducts(_ error: String) {
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let products = responseData else { return }
        
        if searchText.isEmpty {
            isSearching = false
            filteredProducts.removeAll()
        } else {
            isSearching = true
            filteredProducts = products.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        homeTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredProducts.removeAll()
        homeTableView.reloadData()
    }
}

extension HomeViewController: DelegateCustomNavigationBar {
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
