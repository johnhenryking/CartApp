//
//  Product.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    var productId: Int
    var description: String
    var name: String
    var price: Double
    
    var categoryId: Int
    var category: String
    var images: [ImageUrls]
    
    var parentCompany: String
    var kind: String
    
}
