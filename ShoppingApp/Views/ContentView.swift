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
            
            if user.userIsAuthenticated && !user.userIsAuthenticatedAndSynced {
                LoadingView()
            }
            else if user.userIsAuthenticatedAndSynced{
                    TabView{
                        MainView().tabItem {
                            Image(systemName: "house.fill")
                        }.tag(0)
                        SearchView().tabItem {
                            Image(systemName: "magnifyingglass")
                        }.tag(1)
                        CartView().tabItem {
                            Image(systemName: "cart.fill")
                        }.tag(2)
                        ObservedView().tabItem {
                            Image(systemName: "eye.fill")
                        }.tag(3)
                        ProfileView().tabItem {
                            Image(systemName: "person.fill")
                        }.tag(4)
                    }.accentColor(.black)
    
                    ProfileView()
            }
            else{
                AuthenticationView()

            }

                
//            if (user.userIsAuthenticatedAndSynced ){
//                TabView{
//                    MainView().tabItem {
//                        Image(systemName: "house.fill")
//                    }.tag(0)
//                    SearchView().tabItem {
//                        Image(systemName: "magnifyingglass")
//                    }.tag(1)
//                    ObservedView().tabItem {
//                        Image(systemName: "eye.fill")
//                    }.tag(2)
//                    CartView().tabItem {
//                        Image(systemName: "cart.fill")
//                    }.tag(3)
//                    ProfileView().tabItem {
//                        Image(systemName: "person.fill")
//                    }.tag(4)
//                }.accentColor(.black)
//
//                ProfileView()
//            }
//            else{
//                AuthenticationView()
//            }
        }
        .onAppear{
            if user.userIsAuthenticated{
                user.sync()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
