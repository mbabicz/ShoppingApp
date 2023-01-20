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
            if self.productVM.products != nil{
                if self.searchText != "" && !self.searchText.isEmpty {
                    List{
                        ForEach(self.productVM.products!.filter{(self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText))}, id: \.id){ id in
                            Text(id.name)
                        }
                    }
                }
                else {
                    VStack(alignment: .leading){
                        List{
                            Section(header: Text("Kategorie")){
                                
                                //NavigationLink(destination: SearchResults(category: "Komputery"), label: Text("Komputery"))
                                Text("Smartfony")
                                Text("Słuchawki")
                            }
                            
                        }
                        .listStyle(.grouped)
                        .scrollDisabled(true)
                        .scrollContentBackground(.hidden)

                    }
                }
                
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Produkty").font(.headline).bold()
            }
        }
        .background(.gray.opacity(0.1))
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        
    }


    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
