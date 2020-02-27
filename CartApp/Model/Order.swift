//
//  Cart.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

class Order: Decodable {
    
    var cart: Cart
    var paymentMethod: String
    var postalCode: String
    var user: User
    
    
}
