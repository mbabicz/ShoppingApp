//
//  ProductCardList.swift
//  ShoppingApp
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct ProductCardList: View {
    
    let products: [Product]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var product: Product? = nil

    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(products){product in
                VStack {
                    NavigationLink(destination: ProductDetailsView(product: product)){
                        ProductCard(product: product)
                    }

                }

            }

        }

    }
    
}

struct ProductCardList_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardList(products: Product.sampleProducts)
            .environmentObject(ProductViewModel())
    }
}
