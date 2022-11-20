//
//  UserViewModel.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserViewModel: ObservableObject {
    
    @Published var user: User?
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    

    func signUp(email: String, password: String, username: String){
        auth.createUser(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    self.add(User(username: username, userEmail: email))
                    self.sync()
                }
            }
        }
    }
    
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    //Success
                    self.sync()
                }
            }
        }
    }

//    func signUp(email: String, password: String, username: String){
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
//                self.showingAlert = true
//
//            } else{
//                DispatchQueue.main.async {
//                    let userID = self.auth.currentUser!.uid
//                    print(userID)
//
//                    self.db.collection("Users").document(userID).setData([
//                        "username" : username,
//                        "email" : email,
//                        "date of registration" : Date.now
//                    ])
//                    self.sync()
//                }
//
//            }
//        }
//    }
//
    

//
//    func signUp(email: String, password: String, username: String){
//        auth.createUser(withEmail: email, password: password){ [weak self] result, error in
//            guard result != nil, error == nil else { return }
//            DispatchQueue.main.async {
//                self?.add(User(username: username))
//                self?.sync()
//            }
//
//        }
//    }
    
    func signOut(){
        do{
            try auth.signOut()
            self.user = nil
        }
        catch{
            print("Error signing out user: \(error)")
        }
    }
    
    //MARK: firestore functions for user data
    
    func sync(){
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { document, error in
            guard document != nil, error == nil else { return }
            do{
                try self.user = document!.data(as: User.self)
            } catch{
                print("sync error: \(error)")
            }
        }
    }
    
    private func add(_ user: User){
        guard userIsAuthenticated else { return }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)

        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func update(){
        guard userIsAuthenticatedAndSynced else { return }
        do{
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
        } catch{
            print("error updating \(error)")
        }
    }
    
}
