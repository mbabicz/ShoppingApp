//
//  Product.swift
//  ShoppingApp
//
//  Created by kz on 21/11/2022.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Int
}

extension Product{
    var imageURL: URL {
        URL(string: image)!
    }
}
