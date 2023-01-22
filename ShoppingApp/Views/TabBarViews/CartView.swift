//
//  CartView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @State private var productIDs = [String]()


    var body: some View {
        NavigationView {
            if self.productIDs.count > 0 {
                VStack{
                    Divider()
                    ScrollView{
                        ForEach(0..<self.productIDs.count, id: \.self) { index in
                            ProductCartLoader(productID: self.productIDs[index])
                            
                        }
                        Button {
                            //productVM.addProductToWatchList(productID: product.id)
                        } label: {
                            
                            HStack{
                                Image(systemName: "eye").bold().font(.body)
                                Text("Do kasy").bold().font(.body)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                            
                        }
                        .padding([.leading, .trailing])
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Koszyk")
                }

            }
            
            else{
                Text("Nie masz żadnego produktu w koszyku.")
                Spacer()
            }
                
        }

        .onAppear{
            productVM.getUserCart(){ productID in
                productIDs = productID
                
            }
            
        }
        
    }
    
}

struct ProductCartLoader: View{
    
    @State var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        NavigationLink(destination: ProductDetailsView(product: product)) {
                            ProductCartCell(product: product)}
                            
                        Divider()
                            .overlay(Color.orange)
                    }
                    
                }

            }
            
        }
        
    }
    
}

struct ProductCartCell: View{
    
    @State var product: Product
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
                            productVM.removeProductFromCart(productID: product.id)
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
                                    .font(.footnote)
                                    .strikethrough()
                                    .foregroundColor(.black).opacity(0.75)
                                    .frame(alignment: .trailing)
                                
                                Text("\(product.onSalePrice)PLN")
                                    .padding([.leading,.trailing])
                                    .foregroundColor(.black)
                                    .font(.footnote)
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
                        
                        Text("quant.")
                        
                    }
                    
                }
                
            }
            
        }

    }

}


struct CartView_Previews: PreviewProvider {
    
    static var previews: some View {
        CartView()
    }
}
