//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView{
            Text("search")
            

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
