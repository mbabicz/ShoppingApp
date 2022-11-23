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
    @Published var productList = [Product]()
    @Published var randomProductList = [Product]()

    @Published var products: [Product]?
    
    
    func loadProducts(){
        self.products = nil
        
        db.collection("Products").getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.products = snapshot.documents.map { doc in
                            return Product(
                                id: doc.documentID as? String ?? "",
                                name: doc["name"] as? String ?? "",
                                img: doc["image_url"] as? String ?? "",
                                price: doc["price"] as? Int ?? 0,
                                amount: doc["amount"] as? Int ?? 0,
                                description: doc["description"] as? String ?? "",
                                category: doc["category"] as? String ?? "",
                                rating: doc["rating"] as? Int ?? 0 )
                        }
                    }
                }
            }
            else{
                print("Error: can't get products from database")
            }
        }
    }
       
    func getData(){
        
        //self.productList = nil
        db.collection("Products").getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.productList = snapshot.documents.map { doc in
                            return Product(
                                id: doc.documentID as? String ?? "",
                                name: doc["name"] as? String ?? "",
                                img: doc["image_url"] as? String ?? "",
                                price: doc["price"] as? Int ?? 0,
                                amount: doc["amount"] as? Int ?? 0,
                                description: doc["description"] as? String ?? "",
                                category: doc["category"] as? String ?? "",
                                rating: doc["rating"] as? Int ?? 0 )
                        }
                    }
                }
            }
            else{
                print("Error: can't get products from database")
            }
        }
    }
    
    
    
//    static var sampleProducts: [Product]{
//        return [Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5), Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5)]
//    }
//    
//    static var sampleProduct: [Product]{
//        return [Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5)]
//    }
    
    
    
}

