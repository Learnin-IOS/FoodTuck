//
//  Home.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 10){
                HStack(spacing: 15){

                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundColor(Color("PrimaryColor"))
                    }

                    Text(HomeModel.userLocation == nil ?  "Locating..." : "Deliver to")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])
                 
                Divider()
                
                HStack(spacing: 15){
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != "" {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        .animation(.easeIn, value: 0.3)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                Spacer()
                
            }
            
            // Non Closable alert if permission is denied
            if HomeModel.noLocation {
                Text("Please enable location access in settings to further move on!!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
    }
        
}

