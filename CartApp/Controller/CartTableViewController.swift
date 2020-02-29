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
    
    
    func retrieveOrder() {
        Network.fetch(NetworkAPI.orderURL) { [unowned self] (result: Result<Order, Error>) in
            switch result {
            case .success(let order):
                self.order = order
                self.getProducts(for: order)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getProducts(for order: Order) {
        guard let url = order.cart.productsURL else { return }
        Network.fetch(url, printResponse: false) { (result: Result<Response, Error>) in
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
    var subtotalCellResueIdentifier = "subtotalCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return self.products.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(forCellAt: indexPath), for: indexPath)
        
        switch indexPath.section {
        case 0:
            guard let subtotalCell = cell as? SubtotalTableViewCell else { return cell }
            subtotalCell.cart = order?.cart
        default:
            guard let cartCell = cell as? CartTableViewCell else { return cell }
            cartCell.product = products[indexPath.row]
        }
        return cell
    }
    
    fileprivate func reuseIdentifier(forCellAt indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0: return subtotalCellResueIdentifier
        default: return reuseIdentifier
        }
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
