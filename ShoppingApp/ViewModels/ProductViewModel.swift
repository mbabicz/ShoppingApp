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
    @Published var products: [Product]?
    
    @Published var userCartProductIDs = [String]()
    @Published var userCartTotalPrice = 0
    @Published var userWatchListProductIDs = [String]()

    //ALERTS
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
    
    func getProducts() {
        self.products = nil
        
        db.collection("Products").getDocuments { snapshot, error in
            guard error == nil else {
                print("Error: can't get products from database")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                self.products = snapshot.documents.compactMap { doc -> Product? in
                    guard let name = doc["name"] as? String else { return nil }
                    let id = doc.documentID
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
    
    func getOnSaleProducts(){
        self.onSaleProducts = nil
        
        db.collection("Products").whereField("isOnSale", isEqualTo: true).getDocuments { snapshot, error in
            guard error == nil else {
                print("Error: can't get products from database")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                self.onSaleProducts = snapshot.documents.compactMap { doc -> Product? in
                    guard let name = doc["name"] as? String else { return nil }
                    let id = doc.documentID
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
    
    func getPromotedProducts(){
        self.promotedProducts = nil
        
        db.collection("Products").whereField("isPromoted", isEqualTo: true).getDocuments { snapshot, error in
            guard error == nil else {
                print("Error: can't get products from database")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                self.promotedProducts = snapshot.documents.compactMap { doc -> Product? in
                    guard let name = doc["name"] as? String else { return nil }
                    let id = doc.documentID
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
    
    func addProductToCart(productID: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Cant get user from db")
            return
        }
        
        let ref = db.collection("Users").document(userID).collection("Cart").document(productID)
        let data: [String: Any] = [
            "date": Timestamp(date: Date()),
            "product": productID
        ]
        
        ref.setData(data) { (error) in
            if let error = error {
                self.alertTitle = "Error"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            } else {
                self.alertTitle = "Success"
                self.alertMessage = "Pomyślnie dodano produkt do listy obserwowanych"
                self.showingAlert = true
            }
        }
    }
    
    func addProductToWatchList(productID: String){
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Cant get user from db")
            return
        }
        
        let ref = db.collection("Users").document(userID).collection("WatchList").document(productID)
        let data: [String: Any] = [
            "date": Timestamp(date: Date()),
            "product": productID
        ]
        
        ref.setData(data) { (error) in
            if let error = error {
                self.alertTitle = "Error"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            } else {
                self.alertTitle = "Success"
                self.alertMessage = "Pomyślnie dodano produkt do listy obserwowanych"
                self.showingAlert = true
            }
        }
        
    }

    
    func getUserCart() {
        self.userCartProductIDs.removeAll()
        self.userCartTotalPrice = 0
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(userID).collection("Cart").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting user cart: \(error)")
            } else if let snapshot = snapshot {
                DispatchQueue.main.async {
                    for document in snapshot.documents {
                        self.userCartProductIDs.append(document.documentID)
                        if let product = self.products?.first(where: { $0.id == document.documentID }) {
                            self.userCartTotalPrice += product.isOnSale ? product.onSalePrice : product.price
                        }
                    }
                }
            }
        }
    }
    
    func calculateCartTotalPrice(products: [Product]) -> Int {
        var totalPrice = 0
        for product in products {
            totalPrice += product.isOnSale ? product.onSalePrice : product.price
        }
        return totalPrice
    }
    
    
    func getUserWatchList(){
        self.userWatchListProductIDs.removeAll()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(userID).collection("WatchList").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting user watchlist: \(error)")
            } else if let snapshot = snapshot {
                DispatchQueue.main.async {
                    for document in snapshot.documents {
                        self.userWatchListProductIDs.append(document.documentID)
                    }
                    print(self.userWatchListProductIDs)
                }
            }
        }
    }
    
    func removeProductFromWatchList(productID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = db.collection("Users").document(userID).collection("WatchList").document(productID)

        ref.delete { error in
            if let error = error {
                print("Error removing document from user's watchlist: \(error)")
            } else {
                print("Product removed from watchlist successfully")
                self.getUserWatchList()
            }
        }
    }
    
    func removeProductFromCart(productID: String){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = db.collection("Users").document(userID).collection("Cart").document(productID)

        ref.delete() { error in
            if let error = error {
                print("Error removing document from user's cart \(error)")
            } else {
                print("Cart product removed succesfully")
                self.getUserCart()
            }
            
        }
        
    }
    
    func submitOrder(productIDs: [String], firstName: String, lastName: String, city: String, street: String, streetNumber: String, houseNumber: String, cardNumber: String, cardHolderFirstname: String, cardHolderLastname: String, cardCVV: String, cardExpirationDate: String, totalPrice: Int){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("Orders").document()

        ref.setData([
            "date" : Timestamp(date: Date()),
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
            "status" : "W przygotowaniu",
            "totalPrice" : totalPrice
            
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
                self.getUserCart()
                
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

