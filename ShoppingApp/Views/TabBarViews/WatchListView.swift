//
//  ObservedView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct WatchListView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    @State private var productIDs = [String]()
    
    var body: some View {
        ScrollView {
            Text("S")
            //            VStack{
            //                ForEach(0..<self.productIDs.count, id: \.self){ index in
            //                    self.productIDs[index]
            //
            //                }
            //            }
            //            //Text(productVM.userWatchListProductIDs!)
            //
            //        }
            //        .onAppear{
            //            productVM.getUserWatchList(){ productID in
            //                productIDs = productID
            //            }
            //        }
            //
            //
            //    }
            //    //.navigationBarTitleDisplayMode(.inline)
            //    //    .toolbar{
            //           // ToolbarItem(placement: .principal){
            //               // Text("Obserwowane").font(.headline).bold()
            //           // //}
            //       // }
            
        }
    }
}


struct WatchListCell: View{
    
    var product: Product
    
    var body: some View{
        HStack{
            ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
            VStack{
                Text(product.name)
                    .lineLimit(2)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    .foregroundColor(.black)
                HStack{
                    Text("gwiazdki")
                        .padding([.leading, .trailing])
                        .foregroundColor(.black)
                    Spacer()
                    if product.isOnSale{
                        VStack{
                            Text("\(product.price)")
                                .bold()
                               .padding([.top, .leading, .trailing])
                                .font(.callout)
                                .strikethrough()
                                .foregroundColor(.black).opacity(0.75)
                                .frame(alignment: .trailing)

                            Text("\(product.onSalePrice)PLN")
                                .padding([.leading,.trailing])
                                .foregroundColor(.black)
                        }
                        .frame(alignment: .center)
                    }
                    else {
                        Text("\(product.price)PLN")
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                    }
                    

                }

            }

        }

//        .background(
//                NavigationLink(destination: ProductDetailsView(product: product)) {}
//                    .opacity(0)
//            )

    }

    
}

struct ObservedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
