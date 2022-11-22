//
//  ProfileView.swift
//  ShoppingApp
//
//  Created by kz on 16/11/2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var user: UserViewModel
    let auth = Auth.auth()

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Image(systemName: "person").resizable().aspectRatio(contentMode: .fit).padding(.all).frame(width: 125, height: 125, alignment: .top)
                    
                    
                    VStack{
                        //Text(auth.currentUser?.email ?? "username").bold().font(.system(size: 20))
                        if !user.userIsGuest{
                            Text(user.user?.username ?? "username").bold().font(.system(size: 20))
                            Text(auth.currentUser?.email ?? "user email")
                        }
                        else {
                            Text("Guest").bold().font(.system(size: 20))

                        }
                           
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .border(.green)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading).padding()
                .border(.red)
                Spacer()


                VStack{
                    List{
                        Section(header: Text("Ogólne")){
                            Text("Zamówienia")
                            Text("Moje dane")
                            Text("Metody płatności")
                            
                        }
                        
                    }
                    .listStyle(.grouped)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .frame(height:175)

                    
                    List{
                        Section(header: Text("Konto")){
                            Text("Zmień hasło")
                            Text("Ustawienia prywatności")
                            Text("Usuń konto")
                            
                        }
                        
                    }
                    .listStyle(.grouped)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .frame(height:175)


                    
                    List{
                        Section(header: Text("Ustawienia")){
                            Text("Powiadomienia")
                            Text("Historia")
                            Text("Informacje")
                            
                        }
                        
                    }
                    //.listStyle(.grouped)
                    .listStyle(.grouped)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .frame(height:175)
                    
//                    Button {
//
//                    } label: {
//                        Text("Wyloguj się").font(.system(size:20))
//                    }

                }
                Spacer()


                
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Profil").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        user.signOut()
                        //viewModel.signedIn = false
                    } label: {
                        Text("Wyloguj się").font(.headline).foregroundColor(.blue)
                    }

                }
                
            }
            //.border(.green)
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.border(.gray)
            .background(.gray.opacity(0.1))
            
        }

    }
}


struct ProfileView_Previews: PreviewProvider {
    static let myEnvObject = UserViewModel()

    static var previews: some View {
        ProfileView().environmentObject(myEnvObject)
    }
}
