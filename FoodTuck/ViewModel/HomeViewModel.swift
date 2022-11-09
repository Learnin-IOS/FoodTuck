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
    
    // Location Details
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu
     @Published var showMenu = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Location access
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("Unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestAlwaysAuthorization()
            // Modifying Info.plist
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         // Reading user location and extracting Details
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            
            guard let safeData = res else {return}
            
            var address = ""
            
            // getting area and location name
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
            
        }
    }
}
