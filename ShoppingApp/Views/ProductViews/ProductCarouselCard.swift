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
                VStack(alignment: .leading){
                    Text(product.name.uppercased())
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)

                    Spacer()
                    
                    HStack(spacing: 2) {
                        //Text("\(product.formatedRating)").font(.title3)
                        ForEach(0..<Int(product.productRatingAvarage)){ idx in
                            Image(systemName: "star.fill").font(.subheadline)


                        }
                        if (product.productRatingAvarage != floor(product.productRatingAvarage)){
                            Image(systemName: "star.leadinghalf.fill").font(.subheadline)


                        }
                        ForEach(0..<Int(Double(5) - product.productRatingAvarage)){ idx in
                            Image(systemName: "star").font(.subheadline)

                        }


                        Text("(\(product.ratedBy))").font(.caption2)
                            .foregroundColor(.secondary)
                            .offset(y: 3)
                    }
                    
                    if product.isOnSale{
                        VStack{
                            Text("\(product.price)")
                                .bold()
                                .padding([.top, .leading, .trailing])
                                .font(.callout)
                                .strikethrough()
                                .foregroundColor(.black).opacity(0.75)
                                .frame(alignment: .trailing)


                            Text("\(product.onSalePrice)PLN")
                            

                        }
                        .frame(alignment: .center)
                        .padding(.bottom)
      
                    }
                    else {
                        Text("\(product.price)PLN")
                            .bold()
                            .padding(.bottom)

                    }
   
                }
                .foregroundColor(.black).opacity(0.9)
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
        ProductCarouselCard(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5,  ratedBy: 2, isOnSale: true, onSalePrice: 5000))
    }
}
