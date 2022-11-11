//
//  Cart.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 11/11/2022.
//

import SwiftUI

struct Cart: Identifiable{
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
