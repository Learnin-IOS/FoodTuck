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
    @Published var filtered: [Item] = []
    
    // Cart Data...
    
    @Published var cartItems : [Cart] = []
    @Published var ordered = false
    
    
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
                let details = doc.get("item_details") as! String
                let image = doc.get("item_image") as! String
                let rating = doc.get("item_rating") as! String
                
                return Item(id: id, item_name: name, item_details: details, item_cost: cost, item_rating: rating, item_image: image)
            })
            
            self.filtered = self.items
        }
    }
    
    // Search or Filter
    
    func filterData(){
        withAnimation(.linear){
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    // Add to cart function...
    
    func addToCart(item: Item){
        // checking whether item is added to cart
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        //updating filtered array for search bar results
        let filteredIndex = self.filtered.firstIndex { item1 -> Bool in
            return item.id == item1.id
        } ?? 0
        
        self.filtered[filteredIndex].isAdded = !item.isAdded 
        
        if item.isAdded{
            
            // removing from list..
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        // else adding
        
        self.cartItems.append(Cart(item: item, quantity: 1))
    }
    
    func getIndex(item: Item, isCartIndex: Bool) -> Int {
        let index = self.items.firstIndex { item1 -> Bool in
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { item1 -> Bool in
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    func calculateTotalPrice() -> String{
        
        var price: Float = 0
        
        cartItems.forEach { item in
            price += Float(item.quantity) * Float(truncating: item.item.item_cost)
        }
        
        return getPrice(value: price)
    }
    
    
    func getPrice(value: Float) -> String {
        
        let format = NumberFormatter()
        format.numberStyle =  .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
        
        
    }
    
    //  Writing oder Data into Firebase
    
    func updateOrder(){
        
        let db = Firestore.firestore()
        
        // creating dict of food Details
        if ordered {
            
            ordered = false
            db.collection("Users").document(Auth.auth().currentUser!.uid).delete() { err in
                
                if err != nil {
                    self.ordered = true
                }
            }
            return
        }
        
        
        
        // creating dict of food details  ...
        var details : [[String : Any]] = []
        cartItems.forEach { cart in
            details.append([
                "item_name": cart.item.item_name,
                "item_quantity": cart.quantity,
                "item_cost" :cart.item.item_cost
            ])
        }
        
        ordered = true
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            "ordered_food":details,
            "total_cost" : calculateTotalPrice(),
            "location" : GeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
        ]) {
            err in
            if err != nil {
                self.ordered = false
                return
            }
            
        }
        
    }
    
    
    
}
