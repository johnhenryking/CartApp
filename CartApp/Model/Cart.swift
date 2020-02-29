//
//  Cart.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

struct Cart: Decodable {
    
    var products: [ProductInformation]
    
    var subtotal: String  {
        let prices = products.map({ $0.price })
        let subtotal = prices.reduce(0, +)
        return "Subtotal: \(subtotal)"
    }
    
    var items: String {
        return "\(products.count) items"
    }
    
    var productsURL: String? {
        let ids = products.map { $0.id }
        let formattedArray = (ids.map{String($0)}).joined(separator: ",")
        guard let url = URL(string: NetworkAPI.productURL)?.appending("product_ids", value: formattedArray) else { return nil }
        return url.appending("location_id", value: "6").absoluteString
    }
    
}
