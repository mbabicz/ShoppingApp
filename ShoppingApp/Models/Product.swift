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
}

extension Product{
    var imageURL: URL {
        URL(string: img)!
    }
    
//    var formatedRating: String{
//        let avarage = rating/ratedBy
//        var result = ""
//
//        switch avarage{
//        case 0
//        }
//
//        for _ in 0...Int(avarage){
//            result.append("★")
//        }
//        while result.count<5{
//            result += "☆"
//        }
//        return result
//
//    }
    
    var productRatingAvarage: Double {
        let avarage: Double
        avarage = Double(rating)/Double(ratedBy)
        return Double(avarage)
    }
    
//    var formatedRating: String{
//        let avarage = rating/ratedBy
//
//        for _ in 0...Int(avarage){
//            Image(systemName: "star.fill")
//        }
//        
//        while result.count<5{
//            Image(systemName: "star")
//        }
//        return result
//        
//    }
}


//
//var formatedRating: String {
//    var result = ""
//    for _ in 0...Int(rating.rate){
//        result.append("★")
//    }
//    while result.count<5{
//        result += "☆"
//    }
//    return result
//}

