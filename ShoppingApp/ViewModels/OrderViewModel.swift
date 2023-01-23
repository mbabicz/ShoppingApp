//
//  OrderViewModel.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class OrderViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    @Published var orders: [Order]?

    

    func getUserOrders(){
        self.orders = nil
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("Users").document(userID!).collection("Orders")
        ref.getDocuments(){ snapshot, error in
            if error == nil {
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.orders = snapshot.documents.map { doc -> Order in
                            let id = doc.documentID as String
                            let date = doc["date"] as? Date ?? Date.now
                            let productIDs = doc["productIDs"] as? [String] ?? []
                            let firstname = doc["firstName"] as? String ?? ""
                            let lastname = doc["lastName"] as? String ?? ""
                            let city = doc["city"] as? String ?? ""
                            let street = doc["street"] as? String ?? ""
                            let streetNumber = doc["streetNumber"] as? String ?? ""
                            let houseNumber = doc["houseNumber"] as? String ?? ""
                            let cardNumber = doc["cardNumber"] as? String ?? ""
                            let cardHolderFirstname = doc["cardHolderFirstname"] as? String ?? ""
                            let cardHolderLastname = doc["cardHolderLastname"] as? String ?? ""
                            let cardCVV = doc["cardCVV"] as? String ?? ""
                            let cardExpirationDate = doc["cardExpirationDate"] as? String ?? ""
                            let status = doc["status"] as? String ?? ""

                            
                           return Order(id: id, date: date, productIDs: productIDs, firstName: firstname, lastName: lastname, city: city, street: street, streetNumber: streetNumber, houseNumber: houseNumber, cardNumber: cardNumber, cardHolderFirstname: cardHolderFirstname, cardHolderLastname: cardHolderLastname, cardCVV: cardCVV, cardExpirationDate: cardExpirationDate, status: status)
                        }
                        
                    }
                }
            }
        }
    }
    
}
