//
//  RatingView.swift
//  ShoppingApp
//
//  Created by kz on 08/12/2022.
//

import SwiftUI

struct RatingView: View {
    
    @State private var rating: Int?
    var product: Product
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    @ObservedObject var textReview = TextLimiter(limit: 200)
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            HStack(alignment: .center){
                RatedProductImage(imageURL: product.imageURL).frame(alignment: .trailing)
                
                Text(product.name.uppercased())
                    .font(.headline).bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(alignment: .center)
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
            
            Divider()
            
            VStack{
                VStack(alignment: .center){
                    Text("Oceń ten produkt")
                        .padding()
                        .font(.title3)
                        .frame(alignment: .center)
                    
                    RatingStars(rating: $rating, max: 5)
                    if rating != nil {
                        Text("Twoja ocena: \(rating!)")
                    }
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                
                Divider()
                
                Text("Napisz coś o tym produkcie")
                    .padding([.top, .leading, .trailing])
                    .font(.title3)
                    .frame(alignment: .center)
                
                TextField("Opisz ten produkt", text: $textReview.text, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .border(.gray).opacity(0.5)
                    .foregroundColor(.black)
                    .lineLimit(5...12)
                    .padding([.top, .trailing, .leading])
                
                Text("\(textReview.text.count)/200")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .foregroundColor($textReview.hasReachedLimit.wrappedValue ? .red : .black)
            }
            .padding([.top, .bottom])
            
            Spacer()
            
            Button {
                if textReview.text.count < 1 || rating == nil {
                    user.alertTitle = "Error"
                    user.alertMessage = "Pola nie mogą być puste"
                    user.showingAlert = true
                }
                else if textReview.text.count < 5 && rating != nil {
                    user.alertTitle = "Error"
                    user.alertMessage = "Opinia musi mieć conajmniej 5 znaków"
                    user.showingAlert = true
                }
                else {
                    productVM.addProductReview(productID: product.id, rating: rating!, review: textReview.text, username: user.user?.username ?? "username")
                    dismiss()
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
            .padding()
            .edgesIgnoringSafeArea(.bottom)
            Spacer()
            
        }
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct RatedProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 125, height: 125, alignment: .center)
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

class TextLimiter: ObservableObject {
    private let limit: Int
    init(limit: Int){
        self.limit = limit
    }
    
    @Published var text = ""{
        didSet{
            if text.count > self.limit {
                text = String(text.prefix(self.limit))
                self.hasReachedLimit = true
            }else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
    
}

struct RatingStars: View {
    
    @Binding var rating: Int?
    var max: Int = 5
    
    var body: some View {
        HStack(spacing: 2) {
            
            ForEach(1..<(max+1), id: \.self) { index in
                Image(systemName: self.starType(index: index))
                    .font(.title)
                    .foregroundColor(Color.orange)
                    .onTapGesture {
                        self.rating = index
                    }
            }
        }
        .padding([.bottom, .trailing, .leading])
    }
    
    func starType(index: Int) -> String {
        if let rating = self.rating {
            return index <= rating ? "star.fill" : "star"
        }
        else {
            return "star"
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    
    static let myEnvObject = ProductViewModel()

    static var previews: some View {
        RatingView(product: Product.sampleProduct)
            .environmentObject(myEnvObject)
    }
}
