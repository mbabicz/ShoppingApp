//
//  PurchaseView.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import SwiftUI

struct PurchaseView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    var productIDs = [String]()
    
    //personal data
    @State private var firstname = ""
    @State private var lastname = ""
    
    //residence details
    @State private var city = ""
    @State private var street = ""
    @State private var streetNumber = ""
    @State private var houseNumber = ""
    
    //payment details
    @State private var cardHolderFirstname = ""
    @State private var cardHolderLastname = ""
    @State private var cardNumber = ""
    @State private var cardExpirationDate = ""
    @State private var cardCVV = ""




    
    var body: some View {
        
        NavigationView {
            
            if self.productIDs.count > 0 {
                VStack{
                    //Divider()
                    //ScrollView{
//                        ForEach(0..<self.productIDs.count, id: \.self) { index in
//                            PurchaseCartLoader(productID: self.productIDs[index])
//
//                        }
                        Form {
                            Section(header: Text("Dane odbiorcy")){
                                TextField("Imie odbiorcy", text: $firstname)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Nazwisko odbiorcy", text: $lastname)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                            }
                            .listRowInsets(EdgeInsets())

                                                        
                            Section(header: Text("Adres odbiorcy")){
                                TextField("Miasto", text: $city)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Ulica", text: $street)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Numer ulicy", text: $streetNumber)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Numer domu", text: $houseNumber)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())

                                
                            }
                            .listRowInsets(EdgeInsets())

                            
                            Section(header: Text("Dane karty płatniczej")){
                                TextField("Imie właściciela karty", text: $cardHolderFirstname)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Nazwisko właściciela karty", text: $cardHolderLastname)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Numer karty", text: $cardNumber)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Data ważności karty", text: $cardExpirationDate)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                                TextField("Kod cvv karty", text: $cardCVV)
                                    .textFieldStyle(.roundedBorder)
                                    .listRowInsets(EdgeInsets())
                            }
                            .listRowInsets(EdgeInsets())

                            
                        }
                        .foregroundColor(.black)
                        .scrollContentBackground(.hidden)
                        .listRowInsets(EdgeInsets())
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Dokonaj zakupu")
                        Spacer()
                            
                        
                    
                    //}
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationTitle("Dokonaj zakupu")
                    
                    //Spacer()
                    Button {
                        productVM.submitOrder(productIDs: self.productIDs, firstName: self.firstname, lastName: self.lastname, city: self.city, street: self.street, streetNumber: self.streetNumber, houseNumber: self.houseNumber, cardNumber: self.cardNumber, cardHolderFirstname: self.cardHolderFirstname, cardHolderLastname: self.cardHolderLastname, cardCVV: self.cardCVV, cardExpirationDate: self.cardExpirationDate)
                    } label: {
                        
                        HStack{
                            Image(systemName: "eye").bold().font(.body)
                            Text("Kupuje").bold().font(.body)
                            
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
            
            else{
                Text("Nie masz żadnego produktu w koszyku.")
                Spacer()
            }
                
        }

//        .onAppear{
//            productVM.getUserCart(){ productID in
//                productIDs = productID
//                
//            }
//            
//        }
    }
}

struct PurchaseCartLoader: View{
    
    @State var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        PurchaseCartCell(product: product)
                            
                        Divider()
                            .overlay(Color.orange)
                    }
                    
                }

            }
            
        }
        
    }
    
}


struct PurchaseCartCell: View{
    
    @State var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @State var quantity = 0

    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            //.multilineTextAlignment(.center)
                            //.padding([.trailing])
                            .foregroundColor(.black)
                        Spacer()
                        
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
                                        .padding([.leading,.trailing])
                                        .foregroundColor(.black)
                                        .font(.callout)
                                }
                                .frame(alignment: .center)
                            }
                            else {
                                Text("\(product.price)PLN")
                                    .bold()
                                    .font(.callout)
                                    .foregroundColor(.black)
                                    .padding()
                            }
       
                        }

                    }
 

                    
                }
                
            }
            
        }

    }

}
struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
