//
//  Order.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import Foundation

struct Order: Identifiable, Codable, Hashable {
    
    var id: String
    var date: Date
    var productIDs : [String]
    var firstName: String
    var lastName: String
    var city: String
    var street: String
    var streetNumber: String
    var houseNumber: String
    var cardNumber: String
    var cardHolderFirstname: String
    var cardHolderLastname: String
    var cardCVV: String
    var cardExpirationDate: String
    var status: String
    var totalPrice: Int

}
