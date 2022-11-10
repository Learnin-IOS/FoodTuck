//
//  FoodTuckApp.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI
import Firebase

@main
struct FoodTuckApp: App {
    @UIApplicationDelegateAdaptor(AppDelegeate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// Initializing Firebase

class AppDelegeate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
}
