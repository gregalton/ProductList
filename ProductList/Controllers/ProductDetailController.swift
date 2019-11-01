//
//  ProductDetailController.swift
//  ProductList
//
//  Created by Greg Alton on 10/27/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productReviews: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var index: Int?
    var selectedImage: UIImage?
    var product: Product? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = self.selectedImage {
            self.productImage.image = image
        }
        if let prodName = self.product?.productName {
            self.productName.text = prodName
        }
        if let desc = self.product?.longDescription {
            self.longDescription.attributedText = desc.html2Attributed
        }
        if let rating = self.product?.reviewRating {
            self.productRating.text = String(rating)
        }
        if let reviews = self.product?.reviewCount {
            self.productReviews.text = String(reviews)
        }
        if let price = self.product?.price {
            self.price.text = price
        }
        if self.product?.inStock == 1 {
            self.inStock.text = "in stock"
        } else {
            self.inStock.text = "out of stock"
        }
    }
    
}
