//
//  Product.swift
//  ShoppingApp
//
//  Created by kz on 21/11/2022.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var img: String
    var price: Int
    var amount: Int
    var description: String
    var category: String
    var isOnSale: Bool
    var onSalePrice: Int
    
    var details : [String]
    var images : [String]
}

extension Product{
    var imageURL: URL {
        URL(string: img)!
    }
    
    static var sampleProducts: [Product] {
        return [Product(id: "1", name: "macbook pro 15 16/512 i7" , img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg"]),
        Product(id: "3", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 7500, amount: 3, description: "test", category: "laptopy", isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg"]),
        Product(id: "3", name: "macbook pro 13 16/512 m1", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2", price: 15500, amount: 3, description: "test", category: "laptopy", isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2"])]
    }
    
    static var sampleProduct: Product {
        return Product(id: "1", name: "macbook pro 15 16/512 i7" , img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg"])
    }


}
