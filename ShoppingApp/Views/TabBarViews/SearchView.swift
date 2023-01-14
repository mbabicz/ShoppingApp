//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel
    var showCategoryList = true
    
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
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                .border(.red)
                
                List{
                    Section(header: Text("Kategorie")){

                        Text("Komputery")
                        Text("Smartfony")
                        Text("Słuchawki")
                    }

                }
                .listStyle(.grouped)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                
            }

            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Produkty").font(.headline).bold()
                }
            }
            .background(.gray.opacity(0.1))
            
        }

    }

    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
