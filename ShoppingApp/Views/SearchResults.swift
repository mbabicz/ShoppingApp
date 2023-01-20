//
//  SearchResultsView.swift
//  ShoppingApp
//
//  Created by kz on 20/01/2023.
//

import SwiftUI

struct SearchResults: View {
    
    var searchPhrase: String? = nil
    var category: String? = nil
    
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View{

        Text("s")
        }

    }
    




struct SearchResultsView: View {
    
    let products: [Product]

    var body: some View {
        ForEach(0..<products.count, id: \.self){ index in
            NavigationLink(destination: ProductDetailsView(product: products[index])){
                ProductCell(product: products[index])
            }

            .tag(index)

        }
    }
}

struct ProductCell: View {
    
    var product: Product


    
    var body: some View {
        VStack{
            Text(product.name)
            Text(String(product.price))
            Divider()
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(products: Product.sampleProducts)
    }
}
