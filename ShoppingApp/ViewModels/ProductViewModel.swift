//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProductViewModel: ObservableObject {
    
    private let db = Firestore.firestore()

    @Published var promotedProducts: [Product]?
    @Published var onSaleProducts: [Product]?


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
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0
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
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0
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
                                onSalePrice: doc["onSalePrice"] as? Int ?? 0
                                
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
    

    
    
}

