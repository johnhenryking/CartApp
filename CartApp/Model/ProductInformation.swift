//
//  Cart.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

class ProductInformation: Decodable {
    
    var quantity: Int
    var availableForBonus: Bool?
    var categoryId: Int
    var creditCouponPrice: Double
    var discount: Double
    var id: Int
    var price: Double
    var productId: Int
        
    
}
