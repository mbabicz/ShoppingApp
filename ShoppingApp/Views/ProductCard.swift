//
//  ProductCard.swift
//  ShoppingApp
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct ProductCard: View {
    
    var product: Product

    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 195, height: 320, alignment: .center)
                .cornerRadius(15)
                .overlay(
            VStack(alignment: .center){
                ProductCardImage(imageURL: product.imageURL).padding(.top)
                Text(product.name.uppercased())
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                //Text("rating")
                Spacer()

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
  
                }
                else {
                    Text("\(product.price)PLN")
                        .bold()
                        .padding(.bottom)

                }
                    

                Spacer(minLength: 10)
                ZStack(alignment: .center){
                    Button {
                        //
                    } label: {
                        HStack() {
                               Image(systemName: "cart.badge.plus")
                               Text("Do koszyka")
                                   .font(.caption)
                                   .bold()
                           }
                           .padding(8)
                           .foregroundColor(.black)
                           .background(Color(red: 209/255, green: 217/255, blue: 225/255))
                           .cornerRadius(18)
                           
                    }
                }
                .padding(.bottom)
                
            })
            .cornerRadius(12)
            .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            .frame(width: 200, height: 320, alignment: .center)
            
            
        }
        


    }
    
}

struct ProductCardImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 160, height: 160, alignment: .center)
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


struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product(id: "1", name: "macbook pro 13 16/512 intel core i5", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5, isOnSale: true, onSalePrice: 5000))
    }
}
