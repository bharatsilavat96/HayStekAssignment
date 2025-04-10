//
//  AssetManagment.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import Foundation

struct AssetManagement {
    static func screenName(forScreenName: AppEnums.ScreenName) -> String {
        switch forScreenName {
        case .HomeViewController:
            return AssetNames.whiteDimmableLEDON
        case .ProductDetailViewController:
            return "Product Detail Asset"
        case .CatalogueViewController:
            return "Catalogue Asset"
        case .CartViewController:
            return "Cart Asset"
        case .FavoritesViewController:
            return "Favorites Asset"
        case .ProfileViewController:
            return "Profile Asset"
        }
    }
}
