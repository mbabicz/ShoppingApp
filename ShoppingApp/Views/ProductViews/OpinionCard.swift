//
//  OpinionCard.swift
//  ShoppingApp
//
//  Created by kz on 23/12/2022.
//

import SwiftUI

struct OpinionCard: View {
    
    var rate: Int
    var review: String
    var username: String
    var maxRate: Int = 5
    
    var body: some View {
        VStack(alignment: .leading){
            
            Divider().overlay(Color.orange)
            
            HStack(alignment: .center){
                Text(username).padding()
                Spacer()
                Text("DD//MM/YY").padding().foregroundColor(.black).opacity(0.7)
                
            }
            HStack{
                Spacer()
                RateStars(rating: 5, max: 5)
                Spacer()
            }

            Text(review).padding([.leading, .trailing, .bottom])
            
            Divider().overlay(Color.orange)

            
        }
        
    }
    struct RateStars: View {
        
        var rating: Int?
        var max: Int = 5
        
        var body: some View {
            HStack(spacing: 2) {
                
                ForEach(1..<(max+1), id: \.self) { index in
                    Image(systemName: self.starType(index: index))
                        .font(.title3)
                        .foregroundColor(Color.orange)

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
}


struct OpinionCard_Previews: PreviewProvider {
    static var previews: some View {
        OpinionCard(rate: 5, review: "Fajny telefon, szybki i ładny. Troche drogi ale 5/5", username: "Tester1")
    }
}
