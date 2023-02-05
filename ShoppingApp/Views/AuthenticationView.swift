//
//  AuthenticationView.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import SwiftUI


struct AuthenticationView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        SignInView()
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct SignInView: View {
    
    @EnvironmentObject var user: UserViewModel
    @State var email = ""
    @State var password = ""

    @State var isSecured: Bool = true
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("Adres email", text: $email).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Hasło", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Hasło", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    NavigationLink("Zapomniałeś hasła?", destination: ResetPasswordView())
                        .padding([.leading, .bottom, .trailing])
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.orange)
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            user.signIn(email: email, password: password)
                        } else{
                            user.alertTitle = "Error"
                            user.alertMessage = "Pola nie mogą by puste"
                            user.showingAlert = true
                        }

                    } label: {
                        Text("Logowanie")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                            .padding()

                    }

                    Text("Nie masz konta?")
                        .padding([.top, .leading, .trailing])
                    NavigationLink("Załóż konto", destination: SignUpView()).padding([.leading, .bottom, .trailing]).foregroundColor(Color.orange)

                }
                .padding()
                Spacer()
                
                Button {
                    user.signInAnonymously()
                } label: {
                    Text("Kontynuuj jako gość")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.orange)
                }
            }
            .navigationTitle("Logowanie")
        }
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var username = ""
    
    @EnvironmentObject var user: UserViewModel

    @State var isSecured: Bool = true
    @State var isSecuredConfirmation: Bool = true

    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("Nazwa użytkownika", text: $username)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    TextField("Adres email", text: $email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Hasło", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Hasło", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding()
                    }
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecuredConfirmation {
                                SecureField("Hasło", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Hasło", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecuredConfirmation.toggle()
                        } label: {
                            Image(systemName: self.isSecuredConfirmation ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }.padding()
                    }
                    
                    Button("Stwórz konto") {
                        if username.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty {
                            user.updateAlert(title: "Error", message: "Pola nie mogą być puste")
                            return
                        }

                        if password != passwordConfirmation {
                            user.updateAlert(title: "Error", message: "Hasła muszą być takie same")
                            return
                        }

                        user.signUp(email: email, password: password, username: username)
                    }
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(45)
                    .padding()
                    .alert(isPresented: $user.showingAlert) {
                        Alert(title: Text(user.alertTitle), message: Text(user.alertMessage), dismissButton: .default(Text("OK")))
                    }

                }
                .padding()
                Spacer()
            }
            .navigationTitle("Stwórz konto")
        }
    }
}

struct ResetPasswordView: View {
    
    @State var email = ""
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            VStack{
                VStack {
                    TextField("Adres email", text: $email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        if !email.isEmpty {
                            user.resetPassword(email: email)
                        } else {
                            user.updateAlert(title: "Error", message: "Pola nie mogą być puste")
                        }
                    }) {
                        Text("Zresetuj hasło")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                            .padding()
                    }
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Odzyskanie hasła")
        }
        
    }
}
