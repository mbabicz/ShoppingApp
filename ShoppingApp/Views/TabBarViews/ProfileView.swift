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
                                    NavigationLink(destination: UserOrdersView(), label: {
                                        Text("Zamowienia")                            })
                                }
                                
                            }
                            .listStyle(.grouped)
                            .scrollDisabled(true)
                            .scrollContentBackground(.hidden)
                            .frame(height:100)
                            
                            
                            List{
                                Section(header: Text("Ustawienia")){
                                    Text("Powiadomienia")
                                    Text("Informacje o aplikacji")
                                    
                                }
                                
                            }
                            .listStyle(.grouped)
                            .scrollDisabled(true)
                            .scrollContentBackground(.hidden)
                            .frame(height:175)
                            
                            if(!user.userIsAnonymous){
                                List{
                                    Section(header: Text("Konto")){
                                        NavigationLink(destination: ChangePasswordView(), label: {
                                            Text("Zmień hasło")                            })
                                        
                                        Text("Moje dane")
                                        Text("Usuń konto")
                                    }
                                }
                                .listStyle(.grouped)
                                .scrollDisabled(true)
                                .scrollContentBackground(.hidden)
                                .frame(height:175)
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    
                    Spacer()
                    
                }
                //Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Profil")
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Profil").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        user.signOut()
                    } label: {
                        if user.userIsAnonymous{
                            Text("Zaloguj się").font(.headline).foregroundColor(.blue)

                        } else {
                            Text("Wyloguj się").font(.headline).foregroundColor(.blue)

                        }
                    }
                    
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

struct ChangePasswordView: View{
    
    @State var password = ""
    @State var newPassword = ""
    @State var newPassword2 = ""
    
    @State var isSecured: Bool = true
    @State var isSecured2: Bool = true
    @State var isSecured3: Bool = true
    
    @EnvironmentObject var user: UserViewModel

    
    var body: some View{
        VStack{
            
            HStack{
                
                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured {
                            SecureField("Aktualne hasło", text: $password).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("Aktualne hasło", text: $password).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    //.padding([.top, .leading, .trailing])
                    Spacer()
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                    
                }
            }
            .padding([.top, .trailing, .leading])

            HStack{
                
                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured2 {
                            SecureField("Nowe hasło", text: $newPassword).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("Nowe hasło", text: $newPassword).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    //.padding([.top, .leading, .trailing])
                    Spacer()
                    Button {
                        isSecured2.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                }
            }
            .padding([.top, .trailing, .leading])
            
            HStack{

                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured3 {
                            SecureField("Powtórz nowe hasło", text: $newPassword2).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("Powtórz nowe hasło", text: $newPassword2).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    //.padding([.top, .leading, .trailing])
                    Spacer()
                    Button {
                        isSecured3.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                }
                
            }
            .padding([.top, .trailing, .leading])
            
            Button {
                if !password.isEmpty && !newPassword.isEmpty && !newPassword2.isEmpty {
                    if newPassword == newPassword2{
                        user.changePassword(email: user.user!.userEmail, currentPassword: password, newPassword: newPassword){ error in
                            if error != nil {
                                user.alertTitle = "Error"
                                user.alertMessage = error?.localizedDescription ?? "Something went wrong"
                                user.showingAlert = true
                            } else {
                                user.alertTitle = "Succes"
                                user.alertMessage = "Password has been changed succesfully"
                                user.showingAlert = true
                                
                            }
                        }
                        
                    } else {
                        user.alertTitle = "Error"
                        user.alertMessage = "New password fields must be the same"
                        user.showingAlert = true
                    }
                } else {
                    
                    user.alertTitle = "Error"
                    user.alertMessage = "Field cannot be empty"
                    user.showingAlert = true
                }
                
            } label: {
                Text("Zmień hasło")
                    .frame(width: 200, height: 50)
                    .bold()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(45)
                    .padding()
            }
            Spacer()
        }
        .navigationTitle("Zmiana hasła")
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }

    }
}

struct UserOrdersView: View{
        
    @EnvironmentObject var user: UserViewModel
    
    
    var body: some View{
        Text("UserOrdersView")
    }
}
