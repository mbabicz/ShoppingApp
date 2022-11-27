//
//  DetailedProduct.swift
//  ShoppingApp
//
//  Created by kz on 27/11/2022.
//

import SwiftUI

struct DetailedProduct: View {
    
    var product: Product

    var body: some View {
        VStack{
            ProductImage(imageURL: product.imageURL).padding(.top)
            Text("Hello, World!")
        }

    }
}


struct ProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .cornerRadius(15)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct DetailedProduct_Previews: PreviewProvider {
    static var previews: some View {
        DetailedProduct(product: Product(id: "1", name: "macbook pro 13 16/512 intel core i5", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5, isOnSale: true, onSalePrice: 5000))
    }
}
