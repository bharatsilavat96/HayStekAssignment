//
//  AppEnums.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import Foundation
import UIKit

struct AppEnums {
    
    enum AppColor {
        static let primary = UIColor(hex: "#B4F000")
        static let secondary = UIColor(hex: "#EDEDED")
        static let background = UIColor(hex: "#F9F9F9")
        static let productCardBackground = UIColor(hex: "#FFFFFF")
        static let textPrimary = UIColor(hex: "#000000")
        static let textSecondary = UIColor(hex: "#6B6B6B")
        static let saleRed = UIColor(hex: "#FF3B30")
    }
    
    enum AppFont {
        static let heading = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let caption = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    enum ScreenName: String {
        case HomeViewController = "HomeViewController"
        case ProductDetailViewController = "ProductDetailViewController"
        case CatalogueViewController = "CatalogueViewController"
        case CartViewController = "CartViewController"
        case FavoritesViewController = "FavoritesViewController"
        case ProfileViewController = "ProfileViewController"
    }
}
