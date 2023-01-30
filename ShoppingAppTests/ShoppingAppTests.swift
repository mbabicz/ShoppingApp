//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by kz on 30/01/2023.
//

import XCTest

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

        }
        
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

        
    }



}
