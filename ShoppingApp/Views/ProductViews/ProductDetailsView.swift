//
//  ProductDetails.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View {
        ScrollView{
            VStack{
                ProductImage(imageURL: product.imageURL).padding(.top)
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .center){
                                Text(product.name.uppercased())
                                    .font(.title3).bold()
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                                    .padding()
                                    //.padding(.top, 30)
                                
                                HStack{
                                    if product.isOnSale{
                                        VStack{
                                            Text("\(product.price)")
                                                .bold()
                                                .padding([.leading, .trailing])
                                                .font(.callout)
                                                .strikethrough()
                                                .foregroundColor(.black).opacity(0.75)
                                                .frame(alignment: .trailing)


                                            Text("\(product.onSalePrice)PLN")
                                                .font(.headline)

                                        }
                                        .frame(alignment: .center)
                                        .padding([.bottom, .leading, .trailing])
                      
                                    }
                                    else {
                                        Text("\(product.price)PLN")
                                            .bold()
                                            .font(.headline)
                                            .padding([.bottom, .leading, .trailing])

                                    }
                                                                    
                                    HStack(spacing: 2) {
                                        //Text("\(product.formatedRating)").font(.title3)
                                        ForEach(0..<Int(product.productRatingAvarage)){ idx in
                                            Image(systemName: "star.fill").font(.callout)
                                        }
                                        
                                        if (product.productRatingAvarage != floor(product.productRatingAvarage)){
                                            Image(systemName: "star.leadinghalf.fill").font(.callout)
                                        }
                                        
                                        ForEach(0..<Int(Double(5) - product.productRatingAvarage)){ idx in
                                            Image(systemName: "star").font(.callout)
                                        }
                                        
                                        Text("(\(product.ratedBy))").font(.footnote)
                                            .foregroundColor(.secondary)
                                            .offset(y: 3)
                                    }
                                    .padding([.bottom, .trailing, .leading])
                                                                    
                                }
                                HStack{
                                    
                                    Button {
                                        productVM.addProductToCart(productID: product.id)
                                    } label: {
                                        
                                        HStack{
                                            Image(systemName: "cart.badge.plus").bold().font(.body)
                                            Text("Do koszyka").bold().font(.body)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                        .cornerRadius(45)
                                        
                                    }
                                    .padding([.leading, .trailing])

                                    Button {
                                        //
                                    } label: {
                                        
                                        HStack{
                                            Image(systemName: "eye").bold().font(.body)
                                            Text("Obserwuj").bold().font(.body)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                        .cornerRadius(45)
                                        
                                    }
                                    .padding([.leading, .trailing])
                                    
                                }
                                
                                Text("Opis")
                                    .bold()
                                    .font(.title2)
                                    .padding()
                                
                                Text(product.description)
                                    .foregroundColor(.black).opacity(0.75)
                                    .padding([.leading, .trailing, .bottom])
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(100)
                                if(product.details != []){
                                    Text("Specyfikacja")
                                        .bold()
                                        .font(.title2)
                                        .padding()
                                        ForEach(product.details, id: \.self){ detail in
                                            Divider()

                                            Text(detail)
                                        }
                                        .padding(.horizontal, 8)
                                }

         
                                Spacer()

                            }

                }
                Button {
                    //
                } label: {
                    
                    HStack{
                        Image(systemName: "cart.badge.plus").bold().font(.body)
                        Text("Do koszyka").bold().font(.body)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(45)
                    
                }
                .padding()
                .edgesIgnoringSafeArea(.bottom)
            }
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
                .frame(width: 300, height: 300, alignment: .center)

                //.frame(maxWidth: .infinity)
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
        ProductDetailsView(product: Product(id: "1", name: "macbook pro 13\" 16/512GB m1 silver", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "Ultrabook 13,3 cala, laptop z procesorem Apple M1 , 16GB RAM, dysk 512GB SSD, grafika Apple M1, Multimedia: Kamera, Głośniki, Karta graficzna: Zintegrowana. System operacyjny: macOS", category: "laptopy", rating: 5, ratedBy: 1, isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"]))
    }
}
