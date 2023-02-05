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
    @Published var alertTitle = ""
        
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    var uuid: String? {
        return auth.currentUser?.uid
    }
    
    var userIsAuthenticated: Bool {
        return auth.currentUser != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        return user != nil && userIsAuthenticated
    }
    
    var userIsAnonymous: Bool{
        return auth.currentUser?.email == nil
    }
    
    func updateAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showingAlert = true
    }

    func signUp(email: String, password: String, username: String) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.updateAlert(title: "Error", message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.addUser(User(username: username, signUpDate: Date.now, userEmail: email))
                    self.syncUser()
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.updateAlert(title: "Error", message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.syncUser()
                }
            }
        }
    }
    
    func signInAnonymously() {
        auth.signInAnonymously() { authResult, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.addUser(User(username: "guest", signUpDate: Date.now, userEmail: "guest"))
                    self.syncUser()
                }
            } else {
                self.updateAlert(title: "Error", message: error?.localizedDescription ?? "Coś poszło nie tak")
            }
        }
    }
    
    func resetPassword(email: String) {
        auth.sendPasswordReset(withEmail: email) { error in
            if error == nil {
                self.updateAlert(title: "Success", message: "Link zmieniający hasło został wyslany na adres e-mail .")
            } else {
                self.updateAlert(title: "Error", message: error?.localizedDescription ?? "Coś poszło nie tak")
            }
        }
    }


    
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
    
    func syncUser(){
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
    
    private func addUser(_ user: User){
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
    
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void){
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        auth.currentUser?.reauthenticate(with: credential, completion: { (result, error) in
            if let error = error {
                completion(error)
            } else {
                self.auth.currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    completion(error)
                })
            }
        })
    }    
}
