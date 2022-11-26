//
//  CategorizedProductsView.swift
//  ShoppingApp
//
//  Created by kz on 26/11/2022.
//

import SwiftUI

struct CategorizedProductsView: View {
    @EnvironmentObject var productVM: ProductViewModel
    var category: String

    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var product: Product? = nil

    
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(productVM.products!){product in
                VStack {
                    Button {
                        self.product = product
                    } label: {
                        ProductCard(product: product)

                    }
                    //.padding([.leadi, .trailing])

                }

            }

        }
        onAppear{
            productVM.getProducts(category: "Smartfon")

        }
    }
}

//struct CategorizedProductsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorizedProductsView()
//    }
//}
