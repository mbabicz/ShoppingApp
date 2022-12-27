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
    //@Published var productReviews = [[Int: String]]()
    //@Published var productReviews = [[(rate: Int, review: String, ratedBy: String, posted: String)]]()
//    


    
    
    func getOnSaleProducts(){
        self.products = nil
        
        db.collection("Products").whereField("isOnSale", isEqualTo: true).getDocuments { snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        self.onSaleProducts = snapshot.documents.map { doc -> Product in
                            let id = doc.documentID as String
                            let name = doc["name"] as? String ?? ""
                            let img = doc["image_url"] as? String ?? ""
                            let price = doc["price"] as? Int ?? 0
                            let amount = doc["amount"] as? Int ?? 0
                            let description = doc["description"] as? String ?? ""
                            let category = doc["category"] as? String ?? ""
                            let rating = doc["rating"] as? Int ?? 0
                            let ratedBy = doc["ratedBy"] as? Int ?? 0
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            var productReview = [String]()
                            var productRate = [Int]()
                            var productRatedBy = [String]()
                            
                            let ref = self.db.collection("Products").document(id).collection("Reviews")
                            ref.addSnapshotListener{ (snapshot, error) in
                                if error != nil{
                                    print(error?.localizedDescription as Any)
                                }
                                else {
                                    if(snapshot?.isEmpty != true && snapshot != nil){
                                        productReview.removeAll(keepingCapacity: false)
                                        productRate.removeAll(keepingCapacity: false)
                                        productRatedBy.removeAll(keepingCapacity: false)
                                    }
                                    for document in snapshot!.documents{
                                        if let rate = document.get("rating") as? Int {
                                            print(rate)
                                            productRate.append(rate)
                                        }
                                        if let review = document.get("review") as? String {
                                            productReview.append(review)
                                        }
                                        let ratedBy = document.documentID
                                        productRatedBy.append(ratedBy)
                                        
                                        print(" \(productRate) , \(productReview) , \(productRatedBy)")

                                    }
                                }
                                
                            }
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description, category: category, rating: rating, ratedBy: ratedBy, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images, productReview: productReview, productRate: productRate, productRatedBy: productRatedBy)
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
                        self.promotedProducts = snapshot.documents.map{ doc -> Product in
                            let id = doc.documentID as String
                            let name = doc["name"] as? String ?? ""
                            let img = doc["image_url"] as? String ?? ""
                            let price = doc["price"] as? Int ?? 0
                            let amount = doc["amount"] as? Int ?? 0
                            let description = doc["description"] as? String ?? ""
                            let category = doc["category"] as? String ?? ""
                            let rating = doc["rating"] as? Int ?? 0
                            let ratedBy = doc["ratedBy"] as? Int ?? 0
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            var productReview = [String]()
                            var productRate = [Int]()
                            var productRatedBy = [String]()
                            
                            let ref = self.db.collection("Products").document(id).collection("Reviews")
                            ref.addSnapshotListener{ (snapshot, error) in
                                if error != nil{
                                    print(error?.localizedDescription as Any)
                                }
                                else {
                                    if(snapshot?.isEmpty != true && snapshot != nil){
                                        productReview.removeAll(keepingCapacity: false)
                                        productRate.removeAll(keepingCapacity: false)
                                        productRatedBy.removeAll(keepingCapacity: false)
                                    }
                                    for document in snapshot!.documents{
                                        if let rate = document.get("rating") as? Int {
                                            print(rate)
                                            productRate.append(rate)
                                        }
                                        if let review = document.get("review") as? String {
                                            productReview.append(review)
                                        }
                                        let ratedBy = document.documentID
                                        productRatedBy.append(ratedBy)
                                        
                                        print(" \(productRate) , \(productReview) , \(productRatedBy)")

                                    }
                                }
                                
                            }
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description, category: category, rating: rating, ratedBy: ratedBy, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images, productReview: productReview, productRate: productRate, productRatedBy: productRatedBy)
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
                        self.products = snapshot.documents.map { doc -> Product in
                            let id = doc.documentID as String
                            let name = doc["name"] as? String ?? ""
                            let img = doc["image_url"] as? String ?? ""
                            let price = doc["price"] as? Int ?? 0
                            let amount = doc["amount"] as? Int ?? 0
                            let description = doc["description"] as? String ?? ""
                            let category = doc["category"] as? String ?? ""
                            let rating = doc["rating"] as? Int ?? 0
                            let ratedBy = doc["ratedBy"] as? Int ?? 0
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            var productReviews = [String]()
                            var productRates = [Int]()
                            var productRatedBy = [String]()
                            
                            let ref = self.db.collection("Products").document(id).collection("Reviews")
                            ref.addSnapshotListener{ (snapshot, error) in
                                if error != nil{
                                    print(error?.localizedDescription as Any)
                                }
                                else {
                                    if(snapshot?.isEmpty != true && snapshot != nil){
                                        productReviews.removeAll(keepingCapacity: false)
                                        productRates.removeAll(keepingCapacity: false)
                                        productRatedBy.removeAll(keepingCapacity: false)
                                    }
                                    for document in snapshot!.documents{
                                        if let rate = document.get("rating") as? Int {
                                            print(rate)
                                            productRates.append(rate)
                                        }
                                        if let review = document.get("review") as? String {
                                            productReviews.append(review)
                                        }
                                        let ratedBy = document.documentID
                                        productRatedBy.append(ratedBy)
                                        
                                        print(" \(productRates) , \(productReviews) , \(productRatedBy)")

                                    }
                                }
                                
                            }
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description, category: category, rating: rating, ratedBy: ratedBy, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images, productReview: productReviews, productRate: productRates, productRatedBy: productRatedBy)
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
        let review = ["review" : review] as [String : Any]
        let rating = ["rating" : rating] as [String : Any]
        let ratedBy = ["ratedBy" : userID!] as [String : Any]



        ref.setData(date, merge: true)
        ref.setData(product, merge: true)
        ref.setData(review, merge: true)
        ref.setData(rating, merge: true)
        ref.setData(ratedBy, merge: true)

        
        self.alertTitle = "Powodzenie"
        self.alertMessage = "Opinia została dodana pomyślnie"
        self.showingAlert = true

    }
    
    
    
    func checkIfUserRatedProduct(productID: String) -> Bool {
        print("Calling ifUserRated")
        var hasUserRatedProduct = false
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Products").document(productID).collection("Reviews").document(userID!)
        ref.getDocument(){ (document, error) in
            if error == nil {
                print(" ifUserRated = true ")
                hasUserRatedProduct = true
            }
            else {
                print(" ifUserRated = false ")
                hasUserRatedProduct = false
            }
        }
        print(" return ifUserRated \(hasUserRatedProduct) ")
        return hasUserRatedProduct

    }
    
    
    
    
//    func getProductReviews(productID: String){
//        let ref = db.collection("Products").document(productID).collection("Reviews")
//        ref.addSnapshotListener{ (snapshot, error) in
//            if error != nil{
//                print(error?.localizedDescription as Any)
//            }
//            else {
//                if(snapshot?.isEmpty != true && snapshot != nil){
//                    self.productReview.removeAll(keepingCapacity: false)
//                    self.productRate.removeAll(keepingCapacity: false)
//                    self.productRatedBy.removeAll(keepingCapacity: false)
//
//
//                }
//
//                for document in snapshot!.documents{
//                    if let rate = document.get("rating") as? Int {
//                        print(rate)
//                        self.productRate.append(rate)
//                    }
//                    if let review = document.get("review") as? String {
//                        self.productReview.append(review)
//                    }
//                    let ratedBy = document.documentID
//                    self.productRatedBy.append(ratedBy)
//
//                    print(" \(self.productRate) , \(self.productReview) , \(self.productRatedBy)")
//
//
//                }
//            }
//
//        }
//
//    }
    

    
    
}

