//
//  HomeViewModel.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI
import CoreLocation
import Firebase


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
    
    // ItemData
    
    @Published var items: [Item] = []
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
        // After extracting location Logging in ... 
        self.login()
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
    
    
    
    // MARK: - Anonymous Login for reading Database
    
    func login(){
        Auth.auth().signInAnonymously{ (res, err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            // After Logging in Fetch Data
            self.fechData()
        }
        
    }
    
    
    // MARK: - Fetching Item Data
    func fechData(){
        
        let db = Firestore.firestore()
        db.collection("Items").getDocuments { snap, err in
            guard let itemData = snap else {return}
            self.items = itemData.documents.compactMap({ doc -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let details = doc.get("item_details") as! String
                let image = doc.get("item_image") as! String
                
                return Item(id: id, item_name: name, item_details: details, item_cost: cost, item_rating: ratings, item_image: image)
            })
        }
    }
    

}
