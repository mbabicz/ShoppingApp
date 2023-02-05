//
//  ProductCard.swift
//  ShoppingApp
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct ProductCard: View {
    
    @EnvironmentObject var productVM: ProductViewModel
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
                    .foregroundColor(.black)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()

                if product.isOnSale{
                    VStack{
                        Text("\(product.price)")
                            .bold()
                            .foregroundColor(.black)
                            .padding([.leading, .trailing])
                            .font(.footnote)
                            .strikethrough()
                            .foregroundColor(.black).opacity(0.75)
                            .frame(alignment: .trailing)

                        Text("\(product.onSalePrice)PLN")
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    .frame(alignment: .center)
                }
                else {
                    Text("\(product.price)PLN")
                        .bold()
                        .foregroundColor(.black)
                }

                Spacer(minLength: 10)
                ZStack(alignment: .center){
                    Button {
                        productVM.addProductToCart(productID: product.id)
                    } label: {
                        HStack() {
                               Image(systemName: "cart.badge.plus")
                                .bold().font(.callout)
                               Text("Do koszyka")
                                .bold().font(.footnote)
                           }
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
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
        ProductCard(product: Product.sampleProduct)
    }
}
