//
//  ProductCarouselCard.swift
//  ShoppingApp
//
//  Created by kz on 21/11/2022.
//

import SwiftUI

struct ProductCarouselCard: View {
    
    var product: Product
    
    var body: some View {
        ZStack{
            HStack {
                ProductCarouselImage(imageURL: product.imageURL)
                //Image("profile-image")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100)
//                    .padding(.all, 20)
                VStack(alignment: .leading){
                    Text(product.name)
                    //Text("product.title")
                        .font(.subheadline)
                        .lineLimit(3)
                    Text("\(product.price)$")
                    //Text("Price")
                        .bold()
                        .padding(2)
                    HStack(spacing: 2) {
                        //Text("\(product.formatedRating)")
                        Text("rating")
                        //Text(product.rating)
                            .font(.footnote)
                        //Text("(\(product.rating.manualCount))")
                        Text("rating countt")
                            .font(.caption)
                            .offset(y:2)
                    }
                }
                .foregroundColor(.black).opacity(1)
                Spacer()
            }
            .background(Color(red: 209/255, green: 217/255, blue: 225/255))

        }
        .frame(height: 140)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.75), radius: 4, x: 1, y: 2)
        .padding([.leading, .trailing])
    }
}

struct ProductCarouselImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 140, alignment: .center)
                .cornerRadius(12)
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
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
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

struct ProductCarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarouselCard(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5))
    }
}
