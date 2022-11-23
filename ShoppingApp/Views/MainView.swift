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
            VStack(alignment: .leading){
                Text("Polecane")
                    .font(.system(size:28))
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                if(productVM.products != nil){
                    ProductCarousel(products: productVM.products!)
                }

            }
                .border(.red)
            
            VStack(alignment: .leading){
                Text("Odkryj")
                    .font(.system(size:28))
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
//                ProductCarousel(products: productVM.productList.featuredProduct)

                ProductCarouselCard(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5))

            }
                .border(.red)
            
            VStack(alignment: .leading){
                Text("Najczęsciej kupowane")
                    .font(.system(size:28))
                    .multilineTextAlignment(.leading)
                    .padding(.leading)

                ProductCarouselCard(product: Product(id: "1", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5))
                //Spacer()

            }
            Spacer(minLength: 40)
                .border(.red)
            
        }

        .border(.blue)
        .onAppear{
            productVM.loadProducts()
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
