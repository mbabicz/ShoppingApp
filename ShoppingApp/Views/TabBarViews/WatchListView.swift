//
//  ObservedView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct WatchListView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    @State private var productIDs = [String]()
    
    var body: some View {
        NavigationView {
            if self.productIDs.count > 0 {
                VStack{
                    Divider()
                    ScrollView{
                        if self.productIDs.count > 0 {
                            ForEach(0..<self.productIDs.count, id: \.self) { index in
                                ProductWatchListLoader(productID: self.productIDs[index])
                                
                            }
                            
                        }
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Obserwowane")
                }
                
            } else {
                Text("Nie obserwujesz żadnego prodoktu.")
                Spacer()
            }

        }
        
        .onAppear{
            productVM.getUserWatchList(){ productID in
                productIDs = productID
            }
            
        }
        
    }
    
}


struct ProductWatchListLoader: View{
    
    var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        NavigationLink(destination: ProductDetailsView(product: product)) {
                            ProductWatchListCell(product: product)}
                            
                        Divider()
                            .overlay(Color.orange)

                    }
                    
                }

            }
            
        }
        
    }
    
}

struct ProductWatchListCell: View{
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        VStack{
            
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Spacer()
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing])
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            productVM.removeProductFromWatchList(productID: product.id)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding([.leading, .trailing])
                                .clipShape(Circle())
                        }
                        
                    }
 
                    HStack{
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
                                    .padding([.leading,.trailing])
                                    .foregroundColor(.black)
                                    .font(.callout)
                            }
                            
                            .frame(alignment: .center)
                        }
                        else {
                            Text("\(product.price)PLN")
                                .bold()
                                .font(.footnote)
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Button {
                            productVM.addProductToCart(productID: product.id)
                        } label: {
                            HStack() {
                                   Image(systemName: "cart.badge.plus")
                                    .bold().font(.callout)
                                   Text("Do koszyka")                                  .bold().font(.footnote)
                               }

                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                               
                        }
                        .padding(.trailing)
                        
                    }
                    
                }
                
            }
            
        }

    }
    
}



struct ObservedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
