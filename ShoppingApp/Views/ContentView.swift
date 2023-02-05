//
//  ContentView2.swift
//  ShoppingApp
//
//  
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            if !user.userIsAuthenticated {
                AuthenticationView()
            } else if !user.userIsAuthenticatedAndSynced {
                LoadingView()
            } else {
                TabView {
                    MainView().tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                    SearchView().tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                    CartView().tabItem {
                        Image(systemName: "cart.fill")
                    }.tag(2)
                    WatchListView().tabItem {
                        Image(systemName: "eye.fill")
                    }.tag(3)
                    ProfileView().tabItem {
                        Image(systemName: "person.fill")
                    }.tag(4)
                }.accentColor(.orange)
            }
        }
        .onAppear{
            if user.userIsAuthenticated{
                user.syncUser()
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
