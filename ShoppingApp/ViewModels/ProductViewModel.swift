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
    
    @Published var userCartProductIDs = [String]()
    @Published var userWatchListProductIDs = [String]()

    
    @Published var products: [Product]?
    
    @Published var categoryProducts: [Product]?

    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //RATES & REVIEWS
    @Published var productReview = [String]()
    @Published var productRate = [Int]()
    @Published var productRatedByUID = [String]()
    @Published var productRatedBy = [String]()
    @Published var productRatesCount: Int = 0
    @Published var productRatesTotal: Int = 0
    @Published var productRatingAvarage : Double = 0
    
    func getCategoryProducts(category: String){
        self.categoryProducts = nil
        
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
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description,
                                           category: category, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images)
                        }
                    }
                }
            }
            else{
                print("Error: can't get OnSale products from database")
            }
        }
    }
    
    func getProducts(){
        self.products = nil
        
        db.collection("Products").getDocuments { snapshot, error in
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
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description,
                                           category: category, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images)
                        }
                    }
                }
               // print(self.products!)

            }
            else{
                print("Error: can't get OnSale products from database")
            }
        }
    }
    
    func getOnSaleProducts(){
        self.onSaleProducts = nil
        
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
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description,
                                           category: category, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images)
                        }
                    }
                }
            }
            else{
                print("Error: can't get OnSale products from database")
            }
        }
    }
    
    func getPromotedProducts(){
        self.onSaleProducts = nil
        
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
                            let isOnSale = doc["isOnSale"] as? Bool ?? false
                            let onSalePrice = doc["onSalePrice"] as? Int ?? 0
                            let details = doc["details"] as? [String] ?? []
                            let images = doc["images"] as? [String] ?? []
                            
                            
                            return Product(id: id, name: name, img: img, price: price, amount: amount, description: description, category: category, isOnSale: isOnSale, onSalePrice: onSalePrice, details: details, images: images)
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
        
        ref.setData([
            "date" : Date.now,
            "product" : productID,

        ]) { err in
            if err != nil{
                self.alertTitle = "Errors"
                self.alertMessage = err?.localizedDescription ?? "Coś poszło nie tak"
                self.showingAlert = true
            }
            else {
                self.alertTitle = "Pomyślnie dodano produkt do koszyka"
                self.showingAlert = true
            }
        }
        
    }
    
    func addProductToWatchList(productID: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("WatchList").document(productID)
        
        ref.setData([
            "date" : Date.now,
            "product" : productID,

        ]) { err in
            if err != nil{
                self.alertTitle = "Errors"
                self.alertMessage = err?.localizedDescription ?? "Coś poszło nie tak"
                self.showingAlert = true
            }
            else {
                self.alertTitle = "Pomyślnie dodano produkt do listy obserwowanych"
                self.showingAlert = true
            }
        }
        
    }
    
    func getUserCart(completion: @escaping ([String]) -> ()){
        self.userCartProductIDs.removeAll(keepingCapacity: false)
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("Cart")
        
        ref.getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for document in snapshot.documents {
                            self.userCartProductIDs.append(document.documentID)
                        }
                        print(self.userCartProductIDs)
                        completion(self.userCartProductIDs)

                    }
                }
                
            }
        }
    }
    
    func getUserWatchList(completion: @escaping ([String]) -> ()){
        self.userWatchListProductIDs.removeAll(keepingCapacity: false)
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("WatchList")

        ref.getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for document in snapshot.documents {
                            self.userWatchListProductIDs.append(document.documentID)
                        }
                        print(self.userWatchListProductIDs)
                        completion(self.userWatchListProductIDs)
                    }
                }
            }
        }
    }
    
    func removeProductFromWatchList(productID: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("WatchList")

        ref.document(productID).delete() { err in
            if let err = err {
                print("Error removing document from user's watchlist \(err)")
            } else {
                print("Watchlist product removed succesfully")
            }
        }
        
    }
    
    func removeProductFromCart(productID: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("Cart")

        ref.document(productID).delete() { err in
            if let err = err {
                print("Error removing document from user's cart \(err)")
            } else {
                print("Cart product removed succesfully")
            }
        }
        
    }
    
    func submitOrder(productIDs: [String], firstName: String, lastName: String, city: String, street: String, streetNumber: String, houseNumber: String, cardNumber: String, cardHolderFirstname: String, cardHolderLastname: String, cardCVV: String, cardExpirationDate: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("Orders").document()
        ref.setData([
            "date" : Date.now,
            "productIDs" : productIDs,
            "firstName" : firstName,
            "lastName" : lastName,
            "city" : city,
            "street" : street,
            "streetNumber" : streetNumber,
            "houseNumber" : houseNumber,
            "cardNumber" : cardNumber,
            "cardHolderFirstname" : cardHolderFirstname,
            "cardHolderLastname" : cardHolderLastname,
            "cardCVV" : cardCVV,
            "cardExpirationDate" : cardExpirationDate,
            "status" : "W przygotowaniu"

            
            
        ]){ err in
            if err != nil{
                self.alertTitle = "Errors"
                self.alertMessage = err?.localizedDescription ?? "Coś poszło nie tak"
                self.showingAlert = true
            }
            else {
                self.alertTitle = "Zamówienie złożone pomyślnie"
                self.showingAlert = true
                for product in productIDs {
                    self.db.collection("Users").document(userID!).collection("Cart").document(product).delete()
                }
                
            }
            
        }
        
    }
    
    
    func addProductReview(productID: String, rating: Int, review: String, username: String){
        
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Products").document(productID).collection("Reviews").document(userID!)

        ref.setData([
            "date" : Date.now,
            "productID" : productID,
            "review" : review,
            "rating" : rating,
            "ratedByUID" : userID!,
            "ratedBy" : username
        ]){ err in
            if err != nil{
                self.alertTitle = "Errors"
                self.alertMessage = err?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            }
            else {
                self.alertTitle = "Done"
                self.showingAlert = true
            }
        }
//
//        ref.setData(date, merge: true)
//        ref.setData(product, merge: true)
//        ref.setData(review, merge: true)
//        ref.setData(rating, merge: true)
//        ref.setData(ratedByUID, merge: true)
//        ref.setData(ratedBy, merge: true)
//
//        self.alertTitle = "Powodzenie"
//        self.alertMessage = "Opinia została dodana pomyślnie"
//        self.showingAlert = true
        
    }
    
    
    
    
    func getProductReviews(productID: String, completion: @escaping (([String],[Int],[String],[String], Int, Int, Double)) -> ()){
        let ref = db.collection("Products").document(productID).collection("Reviews")
        ref.addSnapshotListener{ (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else {
                if(snapshot?.isEmpty != true && snapshot != nil){
                    self.productReview.removeAll(keepingCapacity: false)
                    self.productRate.removeAll(keepingCapacity: false)
                    self.productRatedByUID.removeAll(keepingCapacity: false)
                    self.productRatedBy.removeAll(keepingCapacity: false)
                    self.productRatesCount = 0
                    self.productRatesTotal = 0
                }
                
                for document in snapshot!.documents{
                    if let rate = document.get("rating") as? Int {
                        self.productRate.append(rate)
                        self.productRatesCount = self.productRatesCount + rate
                    }
                    if let review = document.get("review") as? String {
                        self.productReview.append(review)
                    }
                    if let ratedBy = document.get("ratedBy") as? String {
                        self.productRatedBy.append(ratedBy)
                    }
                    let ratedByUID = document.documentID
                    self.productRatedByUID.append(ratedByUID)
                    
                }
                self.productRatesTotal = snapshot?.count ?? 0
                
                var productRatingAvarage: Double {
                    let avarage: Double
                    if self.productRatesTotal != 0 {
                        avarage = Double(self.productRatesCount)/Double(self.productRatesTotal)
                        return Double(avarage)
                    }
                    else {
                        return 0
                    }
                }
                
                print(" \(self.productRate) , \(self.productReview) , \(self.productRatedBy), \(self.productRatesCount), \(self.productRatesTotal), \(productRatingAvarage)")
                completion((self.productRatedByUID, self.productRate, self.productReview, self.productRatedBy, self.productRatesCount, self.productRatesTotal, productRatingAvarage))
                
            }
            
        }
        
    }
    
}

