//
//  HomeViewModel.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI
import CoreLocation


// MARK: - Fetching User Location
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Location access
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
        case .denied:
            print("denied")
        default:
            print("Unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
