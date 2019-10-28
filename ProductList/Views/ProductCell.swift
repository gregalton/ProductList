//
//  ProductCell.swift
//  ProductList
//
//  Created by Greg Alton on 10/23/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    let baseURLString = "https://mobile-tha-server.firebaseapp.com"
    var product: Product? {
        didSet {
            self.productName.text = product?.productName
            self.productImage.image = nil
            
            if let productImageUrl = product?.productImage {
                if let image = imageCache[productImageUrl] {
                    self.productImage.image = image
                } else {
                    let urlString = "\(baseURLString)\(productImageUrl)"
                    let url = URL(string: urlString)
                    let request = URLRequest(url: url!)
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if(error != nil) {
                            print(error ?? "error loading image")
                            return
                        }
                        let image = UIImage(data: data!)
                        imageCache[productImageUrl] = image
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.productImage.image = image
                        }
                    }.resume()
                }
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.productImage.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
