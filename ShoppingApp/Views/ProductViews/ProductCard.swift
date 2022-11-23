//
//  ProductCarouselCard.swift
//  ShoppingApp
//
//  Created by kz on 21/11/2022.
//

import SwiftUI

struct ProductCard: View {
    
    var body: some View {
        
        VStack{
            List{
                Section(header: Text("Ogólne")){
                    Text("Zamówienia")
                    Text("Moje dane")
                    Text("Metody płatności")
                    
                }
                
            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height:175)
    }

    
//    private let screenSize = UIScreen.main.bounds
//
//
//    var product: Product
//
//    var body: some View {
//        ZStack{
//            VStack {
//                ProductCardImage(imageURL: product.imageURL).padding([.top, .bottom]).border(.red)
//                VStack(alignment: .center){
//                    Text(product.name)
//                        .font(.subheadline)
//                        .lineLimit(3)
//
//                    HStack(spacing: 2) {
//                        //Text("\(product.formatedRating)")
//                        Text("rating")
//                        //Text(product.rating)
//                            .font(.footnote)
//                        //Text("(\(product.rating.manualCount))")
//                        Text("rating countt")
//                            .font(.caption)
//                            .offset(y:2)
//                    }
//
//                    Text("\(product.price)$")
//                        .bold()
//                        .padding(2)
//
//                    Button {
//                        //
//                    } label: {
//                        HStack {
//                            Image(systemName: "cart.badge.plus")
//                            Text("Do koszyka")
//                                .font(.caption)
//                                .bold()
//                        }
//                        .padding(8)
//                        .background(Color(red: 192/255, green: 192/255, blue: 192/255))
//                        .cornerRadius(18)
//                    }
//
//                }
//                .foregroundColor(.black).opacity(1)
//                Spacer()
//            }
//            .background(Color(red: 224/255, green: 224/255, blue: 224/255))
//
//        }
//        .frame()
//        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 1, y: 2)
//        .padding([.leading, .trailing])
    }
}

struct ProductCardImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 150, height: 160, alignment: .center)
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

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5))
    }
}
