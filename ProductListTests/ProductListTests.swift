//
//  ProductListTests.swift
//  ProductListTests
//
//  Created by Greg Alton on 10/23/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import XCTest
@testable import ProductList

class ProductListTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Decided not to implement NetworkService or URLRequests. This test will now fail
//    func testProductsRequestURL() {
//        let request = ProductsRequest(page: 1, numberOfItems: 10)
//        XCTAssertEqual(request.path, "/walmartproducts/1/10/")
//
//        XCTAssertEqual(request.endpointString, "https://mobile-tha-server.firebaseapp.com/walmartproducts/1/10/")
//    }

}
