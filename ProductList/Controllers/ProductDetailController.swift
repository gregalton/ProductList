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
    
    }
    
}
