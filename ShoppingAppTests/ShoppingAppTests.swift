//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by kz on 30/01/2023.
//

import XCTest
import FirebaseAuth



final class ShoppingAppTests: XCTestCase {
    
    

    func testDisplayPromotedProducts(){
        let products = Product.sampleProducts
        let displayPromoted = ProductCarousel(products: products)
        
        
        XCTAssertEqual(displayPromoted.products.count, products.count)
        for (index, displayPromoted) in displayPromoted.products.enumerated(){
            XCTAssertEqual(displayPromoted.name, products[index].name)
            XCTAssertEqual(displayPromoted.price, products[index].price)
            XCTAssertEqual(displayPromoted.id, products[index].id)
            XCTAssertEqual(displayPromoted.description, products[index].description)
            XCTAssertEqual(displayPromoted.category, products[index].category)

        }
        
    }
    
    func testDisplayWatchlistProducts(){
        let product = Product.sampleProduct
        let loadWatchlist = ProductWatchListLoader(productID: product.id)
        
        
        XCTAssertEqual(loadWatchlist.productID, product.id)
        
        let displayWatchlistProduct = ProductWatchListCell(product: product)
        
        XCTAssertEqual(displayWatchlistProduct.product.name, product.name)
        XCTAssertEqual(displayWatchlistProduct.product.price, product.price)
        XCTAssertEqual(displayWatchlistProduct.product.id, product.id)
        XCTAssertEqual(displayWatchlistProduct.product.description, product.description)
        XCTAssertEqual(displayWatchlistProduct.product.category, product.category)



    }
    
    func testDisplayCartProducts(){
        let product = Product.sampleProduct

        
        let displayCartProduct = ProductCartCell(product: product)
        
        XCTAssertEqual(displayCartProduct.product.name, product.name)
        XCTAssertEqual(displayCartProduct.product.price, product.price)
        XCTAssertEqual(displayCartProduct.product.id, product.id)
        XCTAssertEqual(displayCartProduct.product.description, product.description)
        XCTAssertEqual(displayCartProduct.product.category, product.category)

    }


        
    
    func testDisplayOnSaleProducts(){
        let products = Product.sampleProducts
        let displayOnSale = ProductCardList(products: products)
        
        
        XCTAssertEqual(displayOnSale.products.count, products.count)
        for (index, displayOnSale) in displayOnSale.products.enumerated(){
            XCTAssertEqual(displayOnSale.name, products[index].name)
            XCTAssertEqual(displayOnSale.price, products[index].price)
            XCTAssertEqual(displayOnSale.id, products[index].id)
            XCTAssertEqual(displayOnSale.description, products[index].description)
            XCTAssertEqual(displayOnSale.category, products[index].category)

        }
        
    }
    
    func testDisplayDetailedProduct(){
        
        let product = Product.sampleProduct
        let displayDetailed = ProductDetailsView(product: product)
        
        XCTAssertEqual(displayDetailed.product, product)
        
        XCTAssertEqual(displayDetailed.product.name, product.name)
        XCTAssertEqual(displayDetailed.product.price, product.price)
        XCTAssertEqual(displayDetailed.product.id, product.id)
        XCTAssertEqual(displayDetailed.product.description, product.description)
        XCTAssertEqual(displayDetailed.product.category, product.category)

        
    }

    
    func testCalculateCartTotalPrice() {
        
        let sut = ProductViewModel()

        let products = Product.sampleProducts
        let expectedResult = 15000

        let result = sut.calculateCartTotalPrice(products: products)

        XCTAssertEqual(result, expectedResult)
    }




}
