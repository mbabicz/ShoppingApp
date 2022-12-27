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
    
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    private let screenSize = UIScreen.main.bounds
//    init(products: [Product]) {
//        self.products = products



    var body: some View {
        
        VStack{
            TabView(selection: $currentIndex){
                ForEach(0..<products.count, id: \.self){ index in
                    NavigationLink(destination: ProductDetailsView(product: products[index])){
                        ProductCarouselCard(product: products[index])
                    }

                    .tag(index)

                }
                
            }
            .frame(height: 225)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onReceive(timer) { input in
                animateCarousel()
            }
            .onAppear{
                setupAppearance()
            }
//            .sheet(item: $product){product in
//                ProductDetailsView(product: product)
//            }
        }
        
    }
    
    func animateCarousel(){
        if currentIndex <= 3 {
            withAnimation{
            currentIndex += 1
            }
        } else {
            withAnimation{
            currentIndex = 0
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
        ProductCarousel(products: [
            Product(id: "1", name: "macbook pro 15 16/512 i7" , img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 5500, amount: 3, description: "test", category: "laptopy", rating: 5, ratedBy: 2, isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg"], productReview: ["test","test3"], productRate: [3,5], productRatedBy: ["213", "3213"]),
            Product(id: "3", name: "macbook pro 13 16/512", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", price: 7500, amount: 3, description: "test", category: "laptopy", rating: 5, ratedBy: 2, isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg"], productReview: ["test","test3"], productRate: [3,5], productRatedBy: ["213", "3213"]),
            Product(id: "3", name: "macbook pro 13 16/512 m1", img: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2", price: 15500, amount: 3, description: "test", category: "laptopy", rating: 5, ratedBy: 2,  isOnSale: true, onSalePrice: 5000, details: ["es" , "esy"], images: ["https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg m2"], productReview: ["test","test3"], productRate: [3,5], productRatedBy: ["213", "3213"])
        ])
    }
}
