//
//  MainView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View {
        VStack{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    if(productVM.promotedProducts != nil){
                        ProductCarousel(products: productVM.promotedProducts ?? (productVM.products)!)
                    }
                }

                VStack(alignment: .leading){
                    Text("Okazje")
                        .font(.system(size:28))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    if(productVM.onSaleProducts != nil){
                        ProductCardList(products: productVM.onSaleProducts!)
                    }

                }
                //.border(.red)
                Spacer(minLength: 40)
            }


            
        }

        //.border(.blue)
        .onAppear{
            productVM.getProducts(category: "Smartfon")
            productVM.getPromotedProducts()
            productVM.getOnSaleProducts()

        }

    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {

        MainView()
    }
}
