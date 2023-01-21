//
//  ProductDetails.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
    @State private var currentIndex: Int = 0
    @State private var showingReviewView = false
    
    //Rating and reviews
    @State private var rate = [Int]()
    @State private var review = [String]()
    @State private var ratedByUID = [String]()
    @State private var ratedBy = [String]()
    @State private var ratesTotal: Int = 0
    @State private var ratesCount: Int = 0
    @State private var ratesAvarage: Double = 0.0
    
    @State private var currentReviewIndex: Int = 0
    
    var body: some View {
        ScrollView{
            VStack{
                if(product.images.count > 0){
                    TabView(selection: $currentIndex){
                        ForEach(0..<product.images.count, id: \.self){ index in
                            ProductImage(imageURL: URL(string: product.images[index])!)
                                .tag(index)
                            
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(minHeight: 350)
                    
                    .onAppear{
                        UIPageControl.appearance().currentPageIndicatorTintColor = .black
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
                    }
                }
                else {
                    ProductImage(imageURL: product.imageURL)
                    
                }
                
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .center){
                        Text(product.name.uppercased())
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding()
                        
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
                                        .font(.headline)
                                    
                                }
                                .frame(alignment: .center)
                                .padding([.bottom, .leading, .trailing])
                                
                            }
                            else {
                                Text("\(product.price)PLN")
                                    .bold()
                                    .font(.headline)
                                    .padding([.bottom, .leading, .trailing])
                                
                            }
                            
                            HStack(spacing: 2) {
                                
                                ForEach(0 ..< Int(self.ratesAvarage), id: \.self){ _ in
                                    Image(systemName: "star.fill").font(.callout)
                                }
                                
                                if (self.ratesAvarage != floor(self.ratesAvarage)) {
                                    Image(systemName: "star.leadinghalf.fill").font(.callout)
                                    
                                }
                                
                                ForEach(0 ..< Int(Double(5) - self.ratesAvarage), id: \.self){ _ in
                                    Image(systemName: "star").font(.callout)
                                    
                                }
                                
                                
                                Text("(\(self.ratesTotal))").font(.footnote)
                                    .foregroundColor(.secondary)
                                    .offset(y: 3)
                            }
                            .padding([.bottom, .trailing, .leading])
                            
                        }
                        HStack{
                            
                            Button {
                                productVM.addProductToCart(productID: product.id)
                            } label: {
                                
                                HStack{
                                    Image(systemName: "cart.badge.plus").bold().font(.body)
                                    Text("Do koszyka").bold().font(.body)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .cornerRadius(45)
                                
                            }
                            .padding([.leading, .trailing])
                            
                            Button {
                                productVM.addProductToWatchList(productID: product.id)
                            } label: {
                                
                                HStack{
                                    Image(systemName: "eye").bold().font(.body)
                                    Text("Obserwuj").bold().font(.body)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .cornerRadius(45)
                                
                            }
                            .padding([.leading, .trailing])
                            
                        }
                        
                        Text("Opis")
                            .bold()
                            .font(.title2)
                            .padding()
                        
                        Text(product.description)
                            .foregroundColor(.black).opacity(0.75)
                            .padding([.leading, .trailing, .bottom])
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .lineLimit(100)
                        if(product.details != []){
                            Text("Specyfikacja")
                                .bold()
                                .font(.title2)
                                .padding()
                            ForEach(product.details, id: \.self){ detail in
                                Divider()
                                
                                Text(detail)
                            }
                            .padding(.horizontal, 8)
                        }
                        
                        VStack{
                            HStack{
                                Text("Opinie")
                                    .bold()
                                    .font(.title2)
                                    .padding(.top)
                                Text("(\(self.ratesTotal))").font(.callout).offset(y: 10)
                            }
                            
                            if(self.rate != []){
                                TabView(selection: $currentReviewIndex){
                                    ForEach(0 ..< self.ratesTotal, id: \.self){ id in
                                        OpinionCard(rate: self.rate[id], review: self.review[id], username: self.ratedBy[id])
                                        
                                            .tag(id)
                                        
                                    }
                                }
                                .frame(height: 200)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                
                            }
                            else {
                                Text("Ten produkt nie ma żadnej opini")
                                
                            }
                        }
                        
                        
                        Button {
                            
                            if userVM.userIsAnonymous{
                                
                                productVM.alertTitle = "Uwaga!"
                                productVM.alertMessage = "Musisz być zalogowany, aby dodać opinie!"
                                productVM.showingAlert = true

                            }
                            else {
                                showingReviewView = true

                            }

                            
                        } label: {
                            HStack{
                                Image(systemName: "plus").bold().font(.body)
                                Text("Dodaj opinie").bold().font(.body)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(45)
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                Button {
                    //
                } label: {
                    
                    HStack{
                        Image(systemName: "cart.badge.plus").bold().font(.body)
                        Text("Do koszyka").bold().font(.body)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(45)
                    
                }
                .padding()
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .sheet(isPresented: $showingReviewView){
            RatingView(product: product)
        }
        .onAppear{
            productVM.getProductReviews(productID: product.id){ uid, rates, reviews, username, rateCount, rateTotal, rateAvarage in
                
                rate = rates
                review = reviews
                ratedByUID = uid
                ratedBy = username
                ratesCount = rateCount
                ratesTotal = rateTotal
                ratesAvarage = rateAvarage
                
            }
            
        }
        
        .alert(isPresented: $userVM.showingAlert){
            Alert(
                title: Text(userVM.alertTitle),
                message: Text(userVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $productVM.showingAlert){
            Alert(
                title: Text(productVM.alertTitle),
                message: Text(productVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
}

struct ProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(14)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}


struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())

    }
}
