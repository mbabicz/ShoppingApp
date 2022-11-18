//
//  SettingsView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        VStack{
            
            Image("profile-picture").resizable().aspectRatio(contentMode: .fit).padding(.all).frame(width: 150, height: 150)
            
            Text("You are signed in")
            
            Button {
                try? Auth.auth().signOut()
                viewModel.signedIn = false

            } label: {
                Text("Log Out")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.black)
                    .bold()
                    .cornerRadius(8)
                    .padding()
            }

            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
