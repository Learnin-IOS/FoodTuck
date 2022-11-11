//
//  ContentView.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var HomeModel = HomeViewModel()
    var body: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear(perform: {
                           // Calling Localized Delegate
                           HomeModel.locationManager.delegate = HomeModel
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
