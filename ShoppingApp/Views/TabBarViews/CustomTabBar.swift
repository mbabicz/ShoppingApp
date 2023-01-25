//
//  CustomTabBar.swift
//  ShoppingApp
//
//  Created by kz on 03/12/2022.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack(spacing: 0){
            TabBarButton(systemName: "house.circle")
                .background(Color.blue)
            
        }
    }
}

struct TabBarButton : View {
    
    var systemName: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack(spacing: 8){
                Image(systemName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
            }
            .frame(maxWidth: .infinity)
        })
        
    }

}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
