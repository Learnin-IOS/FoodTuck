//
//  Item.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 10/11/2022.
//

import SwiftUI

struct Item: Identifiable{
    
    var id: String
    var item_name: String
    var item_details: String
    var item_cost: NSNumber
    var item_rating: String
    var item_image: String
    
    // to identify wheter it is added to Cart
    var isAdded: Bool = false
}
