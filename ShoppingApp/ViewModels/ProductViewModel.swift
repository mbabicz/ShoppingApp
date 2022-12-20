//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

class ProductViewModel: ObservableObject {
    
    private let db = Firestore.firestore()

    @Published var promotedProducts: [Product]?
    @Published var onSaleProducts: [Product]?
    @Published var userCartProducts: [Product]?
    
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""



    @Published var products: [Product]?
    
    
    func getOnSaleProducts(){
        self.products = nil
        
        db.collection("Products").whereField("isOnSale", isEqualTo: true).getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.onSaleProducts = snapshot.documents.map { doc in
                            return Product(
                                id: doc.documentID as String,
                                name: doc["name"] as? String ?? "",
                                img: doc["image_url"] as? String ?? "",
                                price: doc["price"] as? Int ?? 0,
                                amount: doc["amount"] as? Int ?? 0,
                                description: doc["description"] as? String ?? "",
                                category: doc["category"] as? String ?? "",
                                rating: doc["rating"] as? Int ?? 0,
                                ratedBy: doc["ratedBy"] as? Int ?? 0,
                                isOnSale: doc["isOnSale"] as? Bool ?? false,
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0,
                                details : doc["details"] as? [String] ?? [],
                                images : doc["images"] as? [String] ?? []


                            )
                        }
                    }
                }
            }
            else{
                print("Error: can't get products from database")
            }
        }
    }
    
    func getPromotedProducts(){
        self.products = nil
        
        db.collection("Products").whereField("isPromoted", isEqualTo: true).getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.promotedProducts = snapshot.documents.map { doc in
                            return Product(
                                id: doc.documentID as String,
                                name: doc["name"] as? String ?? "",
                                img: doc["image_url"] as? String ?? "",
                                price: doc["price"] as? Int ?? 0,
                                amount: doc["amount"] as? Int ?? 0,
                                description: doc["description"] as? String ?? "",
                                category: doc["category"] as? String ?? "",
                                rating: doc["rating"] as? Int ?? 0,
                                ratedBy: doc["ratedBy"] as? Int ?? 0,
                                isOnSale: doc["isOnSale"] as? Bool ?? false,
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0,
                                details : doc["details"] as? [String] ?? [],
                                images : doc["images"] as? [String] ?? []


                            )
                        }
                    }
                }
            }
            else{
                print("Error: can't get products from database")
            }
        }
    }
    
    func getProducts(category: String){
        self.products = nil
        
        db.collection("Products").whereField("category", isEqualTo: category).getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.products = snapshot.documents.map { doc in
                            return Product(
                                id: doc.documentID as String,
                                name: doc["name"] as? String ?? "",
                                img: doc["image_url"] as? String ?? "",
                                price: doc["price"] as? Int ?? 0,
                                amount: doc["amount"] as? Int ?? 0,
                                description: doc["description"] as? String ?? "",
                                category: doc["category"] as? String ?? "",
                                rating: doc["rating"] as? Int ?? 0,
                                ratedBy: doc["ratedBy"] as? Int ?? 0,
                                isOnSale: doc["isOnSale"] as? Bool ?? false,
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0,
                                details : doc["details"] as? [String] ?? [],
                                images : doc["images"] as? [String] ?? []
                                
                            )
                        }
                    }
                }
            }
            else{
                print("Error: can't get products from database")
            }
        }
    }
    
        func addProductToCart(productID: String){
            let userID = Auth.auth().currentUser?.uid
            let ref = db.collection("Users").document(userID!).collection("Cart").document(productID)
            let date = ["added to cart date:" : Date.now] as [String : Any]
            let product = ["productID:" : productID] as [String : Any]
            ref.setData(date, merge: true)
            ref.setData(product, merge: true)
    
    
        }
    
    func getUserCart(){
        self.userCartProducts = nil
        let userID = Auth.auth().currentUser?.uid
        var documentsID = [String]()
        
        db.collection("Users").document(userID!).collection("Cart").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        for document in snapshot.documents{
                            documentsID.append(document.documentID)
                            self.db.collection("Products").document(document.documentID).getDocument { document, error in
                                if error == nil{
                                    if let document = document, document.exists{
                                        
                                        
                                        //document.get("name") as? String ?? "",
                                        //img: doc["image_url"] as? String ?? ""
                                    }
                                    
//                                    if document != nil {
//                                        DispatchQueue.main.async{
//                                            self.userCartProducts = document.map { doc in
//                                                return Product(
//                                                    id: doc.documentID as String,
//                                                    name: doc["name"] as? String ?? "",
//                                                    img: doc["image_url"] as? String ?? "",
//                                                    price: doc["price"] as? Int ?? 0,
//                                                    amount: doc["amount"] as? Int ?? 0,
//                                                    description: doc["description"] as? String ?? "",
//                                                    category: doc["category"] as? String ?? "",
//                                                    rating: doc["rating"] as? Int ?? 0,
//                                                    ratedBy: doc["ratedBy"] as? Int ?? 0,
//                                                    isOnSale: doc["isOnSale"] as? Bool ?? false,
//                                                    onSalePrice: doc["onSalePrice"] as? Int ?? 0,
//                                                    details : doc["details"] as? [String] ?? [],
//                                                    images : doc["images"] as? [String] ?? []
//
//                                                )
//                                            }
//                                        }
//                                    }
                                }
                                else{
                                    print("Error: can't get products from database")
                                }
                            }
                        }
                    }
                }
            }
        }
    
        
    }
    
//
//    func getUserCart(){
//        self.userCartProducts = nil
//        let userID = Auth.auth().currentUser?.uid
//
//        db.collection("Users").document(userID!).collection("Cart").getDocuments { snapshot, error in
//            if error == nil{
//
//                if let snapshot = snapshot {
//                    DispatchQueue.main.async{
//                        self.userCartProducts = snapshot.documents.map { doc in
//                            return Product(
//                                id: doc.documentID as String,
//                                name: doc["name"] as? String ?? "",
//                                img: doc["image_url"] as? String ?? "",
//                                price: doc["price"] as? Int ?? 0,
//                                amount: doc["amount"] as? Int ?? 0,
//                                description: doc["description"] as? String ?? "",
//                                category: doc["category"] as? String ?? "",
//                                rating: doc["rating"] as? Int ?? 0,
//                                ratedBy: doc["ratedBy"] as? Int ?? 0,
//                                isOnSale: doc["isOnSale"] as? Bool ?? false,
//                                onSalePrice: doc["onSalePrice"] as? Int ?? 0
//                            )
//                        }
//                    }
//                }
//            }
//            else{
//                print("Error: can't get products from database")
//            }
//        }
//    }
//
    
    
    func addProductReview(productID: String, rating: Int, review: String){
        
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Products").document(productID).collection("Reviews").document(userID!)
        let date = ["date" : Date.now] as [String : Any]
        let product = ["productID" : productID] as [String : Any]
        let review = ["productID" : review] as [String : Any]
        let rate = ["rating" : rating] as [String : Any]


        ref.setData(date, merge: true)
        ref.setData(product, merge: true)
        ref.setData(review, merge: true)
        ref.setData(rate, merge: true)
        
        self.alertTitle = "Powodzenie"
        self.alertMessage = "Opinia została dodana pomyślnie"
        self.showingAlert = true

    }

    
    
}

