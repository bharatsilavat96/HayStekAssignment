//
//  HomeViewModel.swift
//  HayStek
//
//  Created by Bharat Shilavat on 10/04/25.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchProducts(_ products: [ProductResponse])
    func didFailToFetchProducts(_ error: String)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    init() {
        NetworkManager.shared.delegate = self
    }
    
    //MARK: - API CALL -
    func fetchProducts() {
        NetworkManager.shared.startSession(endpoint: .product, method: .get)
    }
    
}

extension HomeViewModel: NetworkManagerDelegate {
    func didCompleteTask(with result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            do {
                let products = try JSONDecoder().decode([ProductResponse].self, from: data)
                delegate?.didFetchProducts(products)
            } catch {
                delegate?.didFailToFetchProducts(error.localizedDescription)
            }
        case .failure(let error):
            print("error -> \(error)")
            delegate?.didFailToFetchProducts(error.localizedDescription)
        }
    }
}

