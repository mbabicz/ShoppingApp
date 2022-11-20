//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.25))
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search...", text: $searchText)
                        
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                    //.border(.red)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                .border(.red)
                
                //Spacer()
                List{
                    Section(header: Text("Kategorie")){
                        Text("kat1")
                        Text("kat2")
                        Text("kat3")
                        Text("kat4")
                        
                    }
                    
                }
                //.listStyle(.grouped)
                .listStyle(.inset)
                .listStyle(.insetGrouped)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                
                
            }
            //Spacer()
                   
            
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Produkty").font(.headline).bold()
                }
            }
            
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
