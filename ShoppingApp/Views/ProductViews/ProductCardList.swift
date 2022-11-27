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
                    Button {
                        self.product = product
                    } label: {
                        ProductCard(product: product)

                    }
                    //.padding([.leadi, .trailing])

                }

            }

        }
        .sheet(item: $product){product in
            ProductDetailsView(product: product)
        }

    }
}

struct ProductCardList_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardList(products: [
            Product(id: "1", name: "macbook pro 15 16/512 i7" , img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5, isOnSale: true, onSalePrice: 5000),
            Product(id: "3", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 7500, amount: 3, description: "test", category: "laptopy", rating: 5, isOnSale: true, onSalePrice: 5000),
            Product(id: "3", name: "macbook pro 13 16/512 m1", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2", price: 15500, amount: 3, description: "test", category: "laptopy", rating: 5, isOnSale: true, onSalePrice: 5000)])
    }
}
