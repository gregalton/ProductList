//
//  ProductController.swift
//  ProductList
//
//  Created by Greg Alton on 10/23/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

struct Root {
    var products: [[String: Any]]?
    var totalProducts: Int?
    var pageNumber: Int?
    var pageSize: Int?
    var statusCode: Int?
    
    init(json: [String: Any]) {
        products = json["products"] as? [[String: Any]] ?? [["": ""]]
        totalProducts = json["totalProducts"] as? Int ?? -1
        pageNumber = json["pageNumber"] as? Int ?? -1
        pageSize = json["pageSize"] as? Int ?? -1
        statusCode = json["statusCode"] as? Int ?? 500
    }
}

import UIKit

class ProductController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var tableView: UITableView!
    
    let endpointString = "https://mobile-tha-server.firebaseapp.com/walmartproducts/"
    
    var totalProducts: Int?
    var pageNumber: Int?
    var pageSize: Int?
    var selectedImage: UIImage?

    var products: [Product]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageNumber = 1
        self.pageSize = 20
        getProducts()
    }
    
    func getProducts() {
        let endpointWithParamsString = "\(endpointString)\(pageNumber ?? 1)/\(pageSize ?? 20)/"
        guard let url = URL(string: endpointWithParamsString) else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if(error != nil) {
                print(error!)
                return
            }
            
            guard let data = data else {return}
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                self?.totalProducts = root["totalProducts"] as? Int
                self?.pageNumber = root["pageNumber"] as? Int
                self?.pageSize = root["pageSize"] as? Int
                
                
                if let productsNode = root["products"] as? [[String: Any]] {
                    var tempProducts = [Product]()
                    for aProduct in productsNode {
                        let product = Product(json: aProduct)
                        tempProducts.append(product)
                        print(product.productName ?? "Name unavailable")
                    }
                    self?.products = tempProducts
                }
                
            } catch let error {
                print("Error parsing product", error.localizedDescription)
            }
            
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = self.products?[indexPath.row] else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! ProductCell
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! ProductCell
        selectedImage = cell.productImage.image
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? ProductDetailController else {return}
            destinationVC.index = indexPath.row
            destinationVC.selectedImage = self.selectedImage
            destinationVC.product = self.products?[indexPath.row]
        }
    }
    
}


