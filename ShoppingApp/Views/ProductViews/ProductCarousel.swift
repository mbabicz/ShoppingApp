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
        ProductCarousel(products: Product.sampleProducts)
    }
}
