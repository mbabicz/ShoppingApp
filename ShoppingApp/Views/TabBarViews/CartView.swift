//
//  CartView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel


    var body: some View {
        NavigationView {
            if self.productVM.userCartProductIDs.count > 0 {
                VStack{
                    Divider()
                    ScrollView{
                        ForEach(0..<self.productVM.userCartProductIDs.count, id: \.self) { index in
                            ScrollView{
                                LazyVStack{
                                        ForEach(self.productVM.products!.filter{$0.id.contains(self.productVM.userCartProductIDs[index])}, id: \.id){ product in
                                            NavigationLink(destination: ProductDetailsView(product: product)) {
                                                ProductCartCell(product: product)}
                                                
                                            Divider()
                                                .overlay(Color.orange)
                                        }
                                        
                                    

                                }
                                
                            }
                            

                        }


                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Koszyk")
                    Spacer()
                    VStack{
                        Divider()
                        HStack{
                            Text("Łączna wartość:")
                                .padding([.leading])

                            Spacer()
                            Text("\(self.productVM.userCartTotalPrice)PLN")
                                .padding([.trailing])
                        }
                        NavigationLink(destination: PurchaseView(productIDs: self.productVM.userCartProductIDs)){
                            HStack{
                                Image(systemName: "eye").bold().font(.body)
                                Text("Dokonaj zakupu").bold().font(.body)

                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                        }
                        .padding([.leading, .trailing, .bottom])
                    }
                }
                

            }
            
            else{
                Text("Koszyk jest pusty")
                Spacer()
            }
                
        }

        .onAppear{
            productVM.getUserCart()

            
        }
        
    }
    
}


struct ProductCartCell: View{
    
    @State var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @State var quantity = 0

    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            //.multilineTextAlignment(.center)
                            //.padding([.trailing])
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
                                    .padding([.leading, .trailing])
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
                                .font(.callout)
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                        Spacer()
                        Text("Ilość: 1")
                            .foregroundColor(.black)
                            .font(.footnote)
                        .padding()
                        

                        
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
