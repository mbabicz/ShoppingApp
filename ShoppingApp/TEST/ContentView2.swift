//
//  ContentView2.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import SwiftUI

struct ContentView2: View {
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView{
            if user.userIsAuthenticatedAndSynced{
                ProfileView()
            }
            else{
                AuthenticationView()
            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
