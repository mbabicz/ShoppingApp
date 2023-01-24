//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationView{
            if self.productVM.products != nil{
                if self.searchText != "" && !self.searchText.isEmpty {
                    ScrollView{
                        LazyVStack{
                            ForEach(self.productVM.products!.filter{(self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText))}, id: \.id){ product in
                                NavigationLink(destination: ProductDetailsView(product: product)) {
                                    SearchCell(product: product)}
                                    
                                Divider()
                                    .overlay(Color.orange)
    
                            }
                        }
                    }

                }
                else {
                    VStack(alignment: .leading){
                        List{
                            Section(header: Text("Kategorie")){
                                
                                NavigationLink(destination: SearchByCategory(category: "Smartfony"), label: {
                                    Text("Smartfony")
                                    
                                })
                                
                                NavigationLink(destination: SearchByCategory(category: "Tablety"), label: {
                                    Text("Tablety")
                                })
      
                                NavigationLink(destination: SearchByCategory(category: "Laptopy"), label: {
                                    Text("Laptopy")
                                })
                                
                                NavigationLink(destination: SearchByCategory(category: "Słuchawki"), label: {
                                    Text("Słuchawki")
                                })
                                
                                NavigationLink(destination: SearchByCategory(category: "Zegarki"), label: {
                                    Text("Zegarki")
                                })
                                
                                NavigationLink(destination: SearchByCategory(category: "Akcesoria"), label: {
                                    Text("Akcesoria")
                                })
                            }
                            
                        }
                        .listStyle(.grouped)
                        .scrollDisabled(true)
                        .scrollContentBackground(.hidden)

                    }
                }
                
            }

        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Produkty").font(.headline).bold()
            }
        }
        .background(.gray.opacity(0.1))
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        
    }


    
}

struct SearchByCategory: View{
    
    var category: String
    @EnvironmentObject var productVM: ProductViewModel
    @State var productCounter: Int = 0

    var body: some View{
        NavigationView{
            if productCounter > 0 {
                ScrollView{
                    LazyVStack{
                        VStack{
                            Text("Znaleziono \(productCounter) produktów")
                            Divider()
                                .overlay(Color.orange)
                            if(self.productVM.products != nil){
                                ForEach(self.productVM.products!.filter{$0.category.contains(self.category) }, id: \.id) { product in
                                    SearchCell(product: product)
                                    Divider()
                                        .overlay(Color.orange)
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                }
            } else {
                Text("Chwilowy brak produktów w tej kategorii")
                Spacer()
            }
            
        }
        .onAppear{
            self.productCounter = self.productVM.products!.filter{$0.category.contains(self.category) }.count
        }
            

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(category)
    }

}

struct SearchCell: View{
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
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
                    Button {
                        productVM.addProductToCart(productID: product.id)
                    } label: {
                        HStack() {
                               Image(systemName: "cart.badge.plus")
                                .bold().font(.callout)
                               Text("Do koszyka")
                                .bold().font(.footnote)
                           }

                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(45)
                           
                    }
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
        
    }
    
}

struct ProductSearchCellImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 80, height: 112, alignment: .center)
                .cornerRadius(12)
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
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchView()
        SearchCell(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())
    }
}
