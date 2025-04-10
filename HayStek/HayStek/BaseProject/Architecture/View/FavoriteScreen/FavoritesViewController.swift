//
//  FavoritesViewController.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import UIKit

class FavoritesViewController: UIViewController {

    weak private var viewModel: FavoriteViewModel?
    private var customNavigationBar : CutomerNavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationBar = CutomerNavigationBar.addCustomNavigationBarOnVC(vcToAddNavigation: self, screenName: .FavoritesViewController)
        customNavigationBar?.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: DelegateCustomNavigationBar {
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

