//
//  Product.swift
//  ProductList
//
//  Created by Greg Alton on 10/23/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import Foundation

struct Product {
    var productId: String?
    var productName: String?
    var shortDescription: String?
    var longDescription: String?
    var price: String?
    var productImage: String?
    var reviewRating: Int?
    var reviewCount: Int?
    var inStock: Int?
    
    init(json: [String: Any]) {
        productId = json["productId"] as? String ?? ""
        productName = json["productName"] as? String ?? ""
        shortDescription = json["shortDescription"] as? String ?? ""
        longDescription = json["longDescription"] as? String ?? ""
        price = json["price"] as? String ?? ""
        productImage = json["productImage"] as? String ?? ""
        reviewRating = json["reviewRating"] as? Int ?? -1
        reviewCount = json["reviewCount"] as? Int? ?? -1
        inStock = json["inStock"] as? Int ?? 0
    }
}
