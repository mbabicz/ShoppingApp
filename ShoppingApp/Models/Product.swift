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
    var rating: Int
}

extension Product{
    var imageURL: URL {
        URL(string: img)!
    }
}

