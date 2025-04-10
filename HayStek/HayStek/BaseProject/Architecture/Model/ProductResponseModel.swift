//
//  ProductResponseModel.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import Foundation


// Product Response model
struct ProductResponse: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.rating, forKey: .rating)
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(String.self, forKey: .category)
        self.image = try container.decode(String.self, forKey: .image)
        self.rating = try container.decode(Rating.self, forKey: .rating)
    }
}

// Rating model
struct Rating: Codable {
    let rate: Double
    let count: Int
    
    
    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case count = "count"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rate, forKey: .rate)
        try container.encode(self.count, forKey: .count)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rate = try container.decode(Double.self, forKey: .rate)
        self.count = try container.decode(Int.self, forKey: .count)
    }
}
