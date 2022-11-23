//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by kz on 13/11/2022.
//

import SwiftUI
import Firebase

@main
struct ShoppingAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let user = UserViewModel()
            let product = ProductViewModel()
            ContentView()
                .environmentObject(user)
                .environmentObject(product)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
