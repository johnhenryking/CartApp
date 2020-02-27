//
//  ViewController.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var order: Order?
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveOrder()
    }
    
    var orderUrl = "https://gopuff-public.s3.amazonaws.com/dev-assignments/product/order.json"
    var productsUrl = "https://prodcat.gopuff.com/api/products"
    
    func retrieveOrder() {
        Network.fetch(orderUrl) { [unowned self] (result: Result<Order, Error>) in
            switch result {
            case .success(let order):
                self.order = order
                self.getProducts(for: order)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getProducts(for order: Order) {
        guard let order = self.order else { return }
        var ids = [Int]()
        for product in order.cart.products {
            ids.append(product.id)
        }
        let formattedArray = (ids.map{String($0)}).joined(separator: ",")
        
        let url = URL(string: productsUrl)?.appending("product_ids", value: formattedArray)
        let finalUrl = url?.appending("location_id", value: "6").absoluteString
        
        Network.fetch(finalUrl!, printResponse: true) { (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                self.products = response.products
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: -TABLEVIEW DELEGATE METHODS
    
    var reuseIdentifier = "cartCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.parentCompany
        cell.imageView?.setImage(with: product.images[0].small)
        return cell
    }


}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}

extension UIImageView {
    
    func setImage(with imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = image },
                                  completion: nil)
            }
            
            }.resume()
    }
    
}
