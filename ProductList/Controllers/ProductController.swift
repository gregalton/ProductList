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
        pageNumber = json["pageNumber"] as? Int ?? 1
        pageSize = json["pageSize"] as? Int ?? -1
        statusCode = json["statusCode"] as? Int ?? 500
    }
}

import UIKit

class ProductController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var tableView: UITableView!
    let loadingCellIdentifier = "loadingCell"
    let endpointString = "https://mobile-tha-server.firebaseapp.com/walmartproducts/"
    
    var totalProducts: Int = 224
    var pageNumber: Int = 1
    var pageSize: Int = 20
    var reloadIndex: Int?
    var selectedImage: UIImage?
    var loading: Bool = false

    var products: [Product] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: loadingCellIdentifier)
        self.pageNumber = 1
        self.pageSize = 20
        getProducts()
    }
    
    func getProducts() {
        
        if loading {
            return
        }
        
        loading = true
        
        let endpointWithParamsString = "\(endpointString)\(pageNumber)/\(pageSize)/"
        print(endpointWithParamsString)
        guard let url = URL(string: endpointWithParamsString) else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if(error != nil) {
                print(error!)
                return
            }
            
            guard let data = data else {return}
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                
                DispatchQueue.main.async {
                    self?.totalProducts = root["totalProducts"] as? Int ?? 224
                    self?.pageNumber += 1

                    if let productsNode = root["products"] as? [[String: Any]] {
                        for aProduct in productsNode {
                            let product = Product(json: aProduct)
                            if self?.products != nil {
                                self?.products.append(product)
                            } else {
                                self?.products = [product]
                            }
                        }
                        self?.loading = false
                        self?.tableView.reloadData()
                    }
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
        //return products?.count ?? 0
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! ProductCell
        cell.product = self.products[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetching row of \(indexPaths)")
        self.getProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "toDetail",
            let destinationVC = segue.destination as? ProductDetailController,
            let index = tableView.indexPathForSelectedRow?.row
        {
            let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! ProductCell
            destinationVC.selectedImage = cell.productImage?.image
            destinationVC.product = products[index]
        }
    }
}


