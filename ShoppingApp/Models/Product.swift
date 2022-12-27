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
    var ratedBy: Int
    var isOnSale: Bool
    var onSalePrice: Int
    
    var details : [String]
    var images : [String]
    
    
    var productReview : [String]
    var productRate : [Int]
    var productRatedBy : [String]
}

extension Product{
    var imageURL: URL {
        URL(string: img)!
    }
    
    var productRatingAvarage: Double {
        let avarage: Double
        if ratedBy != 0 {
            avarage = Double(rating)/Double(ratedBy)
            return Double(avarage)
        }
        else {
            return 0
        }
    }

}
