//
//  CartView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @State var cartProducts: [Product]?
    @State private var productIDs = [String]()


    var body: some View {
        NavigationView {
            ScrollView{
                if self.productIDs.count > 0 {
                    ForEach(0..<self.productIDs.count, id: \.self) { index in
                        Text("index")
                    }
                }
            }
            
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Koszyk").font(.headline).bold()
            }
        }
        .onAppear{
            productVM.getUserCart(){ productID in
                productIDs = productID
            }
        }
        
    }
    
}


struct CartView_Previews: PreviewProvider {
    

    static var previews: some View {
        CartView()
    }
}
