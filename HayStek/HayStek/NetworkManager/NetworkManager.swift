//
//  NetworkManager.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func didCompleteTask(with result: Result<Data, Error>)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    weak var delegate: NetworkManagerDelegate?
    private let apiBaseUrl = "https://fakestoreapi.com"
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private init() {} 
    
    func startSession(endpoint: APIEndpoint, method: HTTPMethod, parameters: [String: Any]? = nil) {
        guard var components = URLComponents(string: apiBaseUrl + endpoint.rawValue) else { return }
        
        if method == .get, let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
        
        guard let url = components.url else { return }
        print("Hitting Url : \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .post, let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                delegate?.didCompleteTask(with: .failure(error))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                self.delegate?.didCompleteTask(with: .failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Invalid data", code: 0, userInfo: nil)
                self.delegate?.didCompleteTask(with: .failure(error))
                return
            }
            
            self.delegate?.didCompleteTask(with: .success(data))
        }
        
        task.resume()
    }
}


enum APIEndpoint: String {
    case product = "/products"
}
