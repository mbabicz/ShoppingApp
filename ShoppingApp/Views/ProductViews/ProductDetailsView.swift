//
//  ProductDetails.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    
    var product: Product


    var body: some View {
        VStack{
            ProductImage(imageURL: product.imageURL).padding(.top)
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.075))
//                    .frame(maxWidth: .infinity)
                    .cornerRadius(15)
                    .overlay(
                        VStack(alignment: .center){
                            Text(product.name.uppercased())
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .padding(.top, 30)
                            Text("rating".uppercased())
                                .padding(.top, 10)
                                .font(.title3)

                            Text("\(product.price)PLN")
                                .padding()
                                .font(.title3
                                )
                            Text(product.description)
                                .padding()
                                .font(.body)

                            Spacer()

                        }
                    )
                    .cornerRadius(12)
                    .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .border(.red)
    }
}

struct ProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .cornerRadius(14)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5, ratedBy: 1, isOnSale: true, onSalePrice: 5000))
    }
}
