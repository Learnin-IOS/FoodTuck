//
//  Menu.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 09/11/2022.
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var homeData: HomeViewModel
    var body: some View {
        
        VStack(){
            
            Button {
                
            } label: {
                HStack(spacing: 15){
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text ("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            
            Spacer()
            
            HStack
            {
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryColor"))
            }
            .padding(10 )
            
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.45)
        .background(Color.white.ignoresSafeArea())
    }
}

