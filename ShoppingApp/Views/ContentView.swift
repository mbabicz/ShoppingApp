//
//  ContentView.swift
//  ShoppingApp
//
//  Created by kz on 13/11/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""

    var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    //Success
                    self.signedIn = true
                }
            }
        }
    }
    
    func signUp(email: String, password: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
                
            } else{
                
                self.signedIn = true
                let userID = self.auth.currentUser!.uid
                print(userID)
                let firestoreDatabase = FirebaseFirestore.Firestore.firestore()
                
                firestoreDatabase.collection("Users").document(userID).setData([
                    "username" : username,
                    "email" : email,
                    "date of registration" : Date.now
                ])
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.signedIn = false
    }
    
}

struct ContentView: View {
        
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                TabView{
                    MainView().tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                    SearchView().tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(0)
                    SettingsView().tabItem {
                        Image(systemName: "gearshape.fill")
                    }.tag(0)

                }.accentColor(.black)
                
                SettingsView()

            } else{
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
        .alert(isPresented: $viewModel.showingAlert){
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

//MARK: Views

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""

    @EnvironmentObject var viewModel: AppViewModel
    @State var isSecured: Bool = true
    
    var body: some View {
        VStack {
            VStack{
                //TODO: Image
                VStack{
                    TextField("Email Adress", text: $email).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Password", text: $password).padding()                        .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $password).padding()                        .disableAutocorrection(true)
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
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            viewModel.signIn(email: email, password: password)
                        } else{
                            viewModel.alertMessage = "Fields cannot be empty"
                            viewModel.showingAlert = true
                        }

                    } label: {
                        Text("Sign In").frame(width: 200, height: 50).bold().foregroundColor(Color.white).background(Color.blue).cornerRadius(8).padding()
                    }

                    Text("Don't have an account yet?")
                        .padding([.top, .leading, .trailing])
                    NavigationLink("Create Account", destination: SignUpView()).padding([.leading, .bottom, .trailing])

                }
                .padding()
                Spacer()
            }
            .navigationTitle("Sign In")

        }
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var username = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var isSecured: Bool = true
    @State var isSecuredConfirmation: Bool = true


    var body: some View {
        VStack {
            VStack{
                //TODO: Image
                VStack{
                    TextField("Username", text: $username).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    TextField("Email Adress", text: $email).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Password", text: $password).padding()                        .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $password).padding()                        .disableAutocorrection(true)
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
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecuredConfirmation {
                                SecureField("Password", text: $passwordConfirmation).padding()                        .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $passwordConfirmation).padding()                        .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecuredConfirmation.toggle()
                        } label: {
                            Image(systemName: self.isSecuredConfirmation ? "eye.slash" : "eye").accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    Button {
                        if (!username.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty ){
                            if password == passwordConfirmation {
                                viewModel.signUp(email: email, password: password, username: username)
                            }
                            else{
                                viewModel.alertMessage = "Your password and confirmation password do not match"
                                viewModel.showingAlert = true
                            }
                            
                        } else {
                            viewModel.alertMessage = "Fields cannot be empty"
                            viewModel.showingAlert = true
                        }
                        
                    } label: {
                        Text("Create Account").frame(width: 200, height: 50).bold().foregroundColor(Color.white).background(Color.blue).cornerRadius(8).padding()
                    }

                }
                .padding()
                Spacer()
            }
            .navigationTitle("Create Account")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
