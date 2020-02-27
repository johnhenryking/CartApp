//
//  Page.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation

struct Page: Decodable {
    
    var totalPages​: Int
    var totalResults​: Int
    var page: Int
    var pageSize: Int
    
}
