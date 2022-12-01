//
//  CartView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                //                if(productVM.userCartProducts != nil){
                //                    Text("koszyk jest pusty")
                //
                //                }
                //                else {
                //                    List(productVM.userCartProducts){ product in
                //
                //
                //                        }
                //
                //                    }
                //                    .listStyle(.grouped)
                //                    .scrollDisabled(true)
                //                    .scrollContentBackground(.hidden)
                //                    .frame(height:175)
                //                }
                //            }
                Text("koszyk jest pusty")
                
                
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            Text("Koszyk").font(.headline).bold()
                        }
                    }
            }
            //        .onAppear{
            //            //productVM.getUserCart()
            //
            //        }
        }
        
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
