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
        Home()
            .onAppear(perform: {
                
                       // Calling Localized Delegate
                       
                       HomeModel.locationManager.delegate = HomeModel
                       HomeModel.locationManager.requestAlwaysAuthorization()
                       
                       // Modifying Info.plist
                       
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
