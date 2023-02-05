//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

enum Categories: String, CaseIterable{
    case smartphones = "Smartfony"
    case tablets = "Tablety"
    case laptops = "Laptopy"
    case headphones = "Słuchawki"
    case watches = "Zegarki"
    case accesories = "Akcesoria"
}

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View {
        NavigationView{
            VStack{
                if self.productVM.products != nil {
                    if !self.searchText.isEmpty {
                        ScrollView{
                            LazyVStack{
                                ForEach(self.productVM.products!.filter { $0.name.localizedCaseInsensitiveContains(searchText) }, id: \.id) { product in
                                    NavigationLink(destination: ProductDetailsView(product: product)) {
                                        SearchCell(product: product)
                                    }
                                    Divider().overlay(Color.orange)
                                }
                            }
                        }
                    } else {
                        List {
                            Section(header: Text("Kategorie")) {
                                ForEach(Categories.allCases, id: \.rawValue) { item in
                                    NavigationLink(destination: SearchByCategory(category: item.rawValue), label: {
                                        Text(item.rawValue)
                                    })
                                }
                            }
                        }
                        .listStyle(.grouped)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Produkty").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        addNewProductView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)

                    }
                }
                
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

struct addNewProductView: View{
    @State var isOnSaleToggle: Bool = false
    @State var isPromotedToggle: Bool = false
    @State private var name = ""
    @State private var price = ""
    @State private var amount = ""
    @State private var description = ""
    @State private var onSalePrice = ""
    
    @EnvironmentObject var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    var allFieldsAreFilled: Bool {
        return self.name != "" && self.price != "" && self.amount != "" && self.description != "" && self.onSalePrice != ""
    }


    var body: some View {
        VStack{
            Form {
                TextField("Nazwa produktu", text: $name)
                TextField("Cena produktu", text: $price)
                TextField("Dostępna ilość", text: $amount)
                TextField("Opis produktu", text: $description)
                TextField("Cena promocyjna", text: $onSalePrice)
                
                Toggle(
                    isOn: $isOnSaleToggle,
                    label: {
                        Text("Czy jest w promocji?")
                    })
                .toggleStyle(SwitchToggleStyle(tint: .green))
                Toggle(
                    isOn: $isPromotedToggle,
                    label: {
                        Text("Czy jest promowany?")
                    })
                .toggleStyle(SwitchToggleStyle(tint: .green))
                Button {
                    //
                } label: {
                    Text("Dodaj zdjęcia produktu")
                }
            }
            
            Spacer()
            Button {
                if allFieldsAreFilled {
                        //
                    self.dismiss()
                } else {
                    productVM.updateAlert(title: "Error", message: "Pola nie mogą być puste")
                }
            } label: {
                HStack{
                    Image(systemName: "eye").bold().font(.body)
                    Text("Dodaj produkt").bold().font(.body)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(45)
            }
            .padding([.leading, .trailing, .bottom])

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())
    }
}
