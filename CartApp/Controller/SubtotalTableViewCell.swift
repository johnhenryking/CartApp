//
//  SubtotalTableViewCell.swift
//  CartApp
//
//  Created by User on 2/28/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import UIKit

class SubtotalTableViewCell: UITableViewCell {

    var cart: Cart? {
        didSet {
            updateCartUI()
        }
    }
    
    func updateCartUI() {
        textLabel?.text = cart?.subtotal
        detailTextLabel?.text = cart?.items
        imageView?.image = nil
    }

}
