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
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async{
                //Success
                self?.signedIn = true
                
            }
            
        }
    }
    
    func signUp(email: String, password: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            self?.signedIn = true
            
            let userID = Auth.auth().currentUser!.uid
            print(userID)
            let firestoreDatabase = FirebaseFirestore.Firestore.firestore()// Firebase.Firestore.firestore()
            var firestoreReference : DocumentReference? = nil
            
            firestoreDatabase.collection("Users").document(userID).setData([
                "username" : username,
                "email" : email,
                "date of registration" : Date.now,
                "profile picture" : "firebasestorage.googleapis.com/v0/b/shoppingapp-34b3d.appspot.com/o/profile-picture.png?alt=media&token=8fac1296-d576-44d8-af35-0045d2107cf0"
                
            ])
        }
    }
    
    
    func signOut(){
        try? auth.signOut()
        self.signedIn = false
    }
}

    
//    func signUp(email: String, password: String, username: String){
//        auth.createUser(withEmail: email, password: password){ [weak self] result, error in
//            guard result != nil, error == nil else{
//                return
//            }
//            //TODO: database userinfo
//            //success
//            self?.signedIn = true
//
//        }
//    }
//}

enum Tab: String {
    case Home
    case Settings
    case Search
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
    
    var body: some View {
        VStack {
            VStack{
                //Image
                VStack{
                    TextField("Email Adress", text: $email).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password).padding()                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    Button {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.signIn(email: email, password: password)

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
    @State var username = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            VStack{
                //Image
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
                    
                    
                    Button {
                        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
                            return
                        }
                        viewModel.signUp(email: email, password: password, username: username)
                        
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
