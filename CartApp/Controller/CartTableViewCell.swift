//
//  CartTableViewCell.swift
//  CartApp
//
//  Created by User on 2/28/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    var product: Product? {
        didSet {
            updateProductUI()
        }
    }
    
    func updateProductUI() {
        guard let product = self.product else { return }
        textLabel?.text = product.name
        detailTextLabel?.text = product.priceName
        imageView?.setImage(with: product.thumbnail)
    }
    
    
    
    

}
