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
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 25){
                         
                        ForEach(HomeModel.items){ item in
                            // Item View
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ItemView(item: item )
                                
                                HStack{
                                    Text("FREE DELIVERY")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(Color("PrimaryColor"))
                                    Spacer(minLength: 0)
                                    
                                    Button {
                                         
                                    } label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color("PrimaryColor"))
                                            .clipShape(Circle())
                                    }

                                }
                                .padding(.trailing, 10)
                                .padding(.top, 10 )
                            })
                            .frame(width: UIScreen.main.bounds.width -  30)
                        }
                    }
                    .padding(.top, 10)
                }
                
            }
            
            // Slide Menu
            
            HStack{
                Menu(homeData: HomeModel)
                // Move efect from left
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.45)
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                        // Closing when taps outside
                .onTapGesture {
                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                }
            )
            
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

