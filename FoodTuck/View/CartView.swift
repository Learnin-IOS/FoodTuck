//
//  CartView.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 11/11/2022.
//

import SwiftUI

struct CartView: View {
    @ObservedObject  var homeData: HomeViewModel
    var body: some View {
        Text("Hello")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

