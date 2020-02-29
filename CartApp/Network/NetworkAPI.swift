//
//  NetworkAPI.swift
//  CartApp
//
//  Created by User on 2/28/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

struct NetworkAPI {
    
    enum URLs: String  {
        case order = "https://gopuff-public.s3.amazonaws.com/dev-assignments/product/order.json"
        case products = "https://prodcat.gopuff.com/api/products"
    }
    
    static var orderURL = URLs.order.rawValue
    static var productURL = URLs.products.rawValue
    
}
