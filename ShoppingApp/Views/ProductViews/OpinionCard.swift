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
        ZStack{
            VStack(alignment: .leading){
                
                HStack(alignment: .center){
                    Text(username)
                        .padding()
                        .font(.body)
                        .foregroundColor(.black).opacity(0.5)
                    Spacer()

                    RateStars(rating: rate, max: 5)
                        .font(.body)

                }
                
                Spacer()

                Text(review).padding([.leading, .trailing, .bottom])
                
                Spacer()

            }
            .frame(height: 120)
        }

        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .cornerRadius(20)
        .shadow(color: Color.orange.opacity(0.75), radius: 5, x: 0, y: 1)
        .padding([.leading, .trailing])

        
        
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
        OpinionCard(rate: 5, review: "Fajny telefon ", username: "Tester1")
    }
}
