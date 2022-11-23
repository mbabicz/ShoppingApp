//
//  ProductCarousel.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct ProductCarousel: View {
    
    @State private var currentIndex: Int = 0
    
    let products: [Product]
    @State private var product: Product? = nil
    
    private let screenSize = UIScreen.main.bounds
//    init(products: [Product]) {
//        self.products = products



    var body: some View {
        
        VStack{
            TabView(selection: $currentIndex){
                ForEach(0..<products.count, id: \.self){ index in
                    Button {
                        withAnimation{
                            self.product = products[index]
                            
                        }
                    } label:{
                        ProductCarouselCard(product: products[index])
                            .frame(width: (screenSize.width - 24))
                            .shadow(color: Color.black.opacity(0.75), radius: 4, x: 1, y: 2)
                        

                    }
                    .tag(index)
                }
            }
            .frame(height: 235)
            .border(.red)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear{
                setupAppearance()
            }
        }
        
        
    }
    
    func setupAppearance(){
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct ProductCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarousel(products: [Product(id: "1", name: "macbook pro 15 16/512 i7" , img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5), Product(id: "3", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 7500, amount: 3, description: "test", category: "laptopy", rating: 5), Product(id: "3", name: "macbook pro 13 16/512 m1", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2", price: 15500, amount: 3, description: "test", category: "laptopy", rating: 5)])
    }
}
