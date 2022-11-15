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
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                //alerter.alert = Alert(title: Text("test"))
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
                
            } else{
                
                self.signedIn = true
                
                let userID = Auth.auth().currentUser!.uid
                print(userID)
                let firestoreDatabase = FirebaseFirestore.Firestore.firestore()// Firebase.Firestore.firestore()
                
                firestoreDatabase.collection("Users").document(userID).setData([
                    "username" : username,
                    "email" : email,
                    "date of registration" : Date.now,
                    "profile picture" : "firebasestorage.googleapis.com/v0/b/shoppingapp-34b3d.appspot.com/o/profile-picture.png?alt=media&token=8fac1296-d576-44d8-af35-0045d2107cf0"
                    
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
    }
}

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""

    @EnvironmentObject var viewModel: AppViewModel
    
    @State var showingAlert : Bool = false
    
    var body: some View {
        VStack {
            VStack{
                //TODO: Image
                VStack{
                    TextField("Email Adress", text: $email).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            viewModel.signIn(email: email, password: password)
                        } else{
                            showingAlert = true
                        }

                    } label: {
                        Text("Sign In").frame(width: 200, height: 50).bold().foregroundColor(Color.white).background(Color.blue).cornerRadius(8).padding()
                    }
                    .alert(isPresented: $showingAlert){
                        Alert(
                            title: Text("Error"),
                            message: Text("Fields cannot be empty"),
                            dismissButton: .default(Text("OK"))
                        )
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
    @State var showingAlert : Bool = false
    @State var alertMessage = ""

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
                    
                    SecureField("Password", text: $password).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Confirm password", text: $passwordConfirmation).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    
                    Button {
                        if (!username.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty ){
                            if password == passwordConfirmation {
                                viewModel.signUp(email: email, password: password, username: username)
                            }
                            else{
                                alertMessage = "Your password and confirmation password do not match"
                                showingAlert = true

                            }
                            
                        } else {
                            alertMessage = "Fields cannot be empty"
                            showingAlert = true

                        }
                        
                    } label: {
                        Text("Create Account").frame(width: 200, height: 50).bold().foregroundColor(Color.white).background(Color.blue).cornerRadius(8).padding()
                    }
                    .alert(isPresented: $showingAlert){
                        Alert(
                            title: Text("Error"),
                            message: Text(self.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
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
