//
//  ObservedView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct ObservedView: View {
    var body: some View {
        NavigationView {
            
            Text("obserw")

            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Obserwowane").font(.headline).bold()
                }
            }
        }
    }
}

struct ObservedView_Previews: PreviewProvider {
    static var previews: some View {
        ObservedView()
    }
}
