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
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                VStack {
                    Circle()
                        .frame(width: 140)
                        .foregroundColor(.white)
                        .shadow(color: .orange, radius: 5)
                        .overlay(content: {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 80, height: 80)
                        })
                        .padding(.top, 10)
                    
                    VStack{
                        if !user.userIsAnonymous{
                            Text(user.user?.username ?? "Hello!").bold().font(.system(size: 20))
                        }
                        ScrollView{
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
                            .listStyle(.grouped)
                            .scrollDisabled(true)
                            .scrollContentBackground(.hidden)
                            .frame(height:175)
                            
                        }
                        
                            

                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    
                    Spacer()

                }
                //Spacer()
            }
//            VStack{
//                HStack{
//
//                    Image(systemName: "person").resizable().aspectRatio(contentMode: .fit).padding(.all).frame(width: 125, height: 125, alignment: .top)
//
//                    VStack{
//                        if !user.userIsGuest{
//                            Text(user.user?.username ?? "username").bold().font(.system(size: 20))
//                            Text(auth.currentUser?.email ?? "user email")
//                        }
//                        else {
//                            Text("Guest").bold().font(.system(size: 20))
//
//                        }
//
//                    }
//                    .frame(maxWidth: .infinity, alignment: .top)
//                    .border(.green)
//                }
//                .frame(maxWidth: .infinity, alignment: .topLeading).padding()
//                .border(.red)
//                Spacer()
//
//
//                VStack{
//                    List{
//                        Section(header: Text("Ogólne")){
//                            Text("Zamówienia")
//                            Text("Moje dane")
//                            Text("Metody płatności")
//
//                        }
//
//                    }
//                    .listStyle(.grouped)
//                    .scrollDisabled(true)
//                    .scrollContentBackground(.hidden)
//                    .frame(height:175)
//
//
//                    List{
//                        Section(header: Text("Konto")){
//                            Text("Zmień hasło")
//                            Text("Ustawienia prywatności")
//                            Text("Usuń konto")
//
//                        }
//
//                    }
//                    .listStyle(.grouped)
//                    .scrollDisabled(true)
//                    .scrollContentBackground(.hidden)
//                    .frame(height:175)
//
//                    List{
//                        Section(header: Text("Ustawienia")){
//                            Text("Powiadomienia")
//                            Text("Historia")
//                            Text("Informacje")
//
//                        }
//
//                    }
//                    .listStyle(.grouped)
//                    .scrollDisabled(true)
//                    .scrollContentBackground(.hidden)
//                    .frame(height:175)
//
//                }
//                Spacer()
 
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Profil").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        user.signOut()
                    } label: {
                        Text("Wyloguj się").font(.headline).foregroundColor(.blue)
                    }

                }
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.1))
            
        }

    }



struct ProfileView_Previews: PreviewProvider {
    static let myEnvObject = UserViewModel()

    static var previews: some View {
        ProfileView()
            .environmentObject(myEnvObject)
    }
}
