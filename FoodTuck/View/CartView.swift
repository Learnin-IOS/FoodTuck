//
//  CartView.swift
//  FoodTuck
//
//  Created by Le Bon B' Bauma on 11/11/2022.
//

import SwiftUI

struct CartView: View {
    @ObservedObject  var homeData: HomeViewModel
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button (action: {present.wrappedValue.dismiss()})
                 {
                    Image(systemName: "chevrom.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(Color("PrimaryColor"))
                }
                
                Text("My Cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                    
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    
                    ForEach(homeData.cartItems) { cart in
                        // Cart View
                        HStack(spacing: 15) {
                            Image(cart.item.item_image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            VStack(alignment: .leading, spacing: 10){
                                Text(cart.item.item_name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(cart.item.item_details)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                HStack(spacing: 15) {
                                    
                                    Text(homeData.getPrice(value: Float(truncating: cart.item.item_cost)))
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    // Add - Sub Button...
                                    Button(action: {
                                        if cart.quantity > 1{
                                            homeData.cartItems[homeData.getIndex(item: cart.item, isCartIndex: true)].quantity -= 1
                                        }
                                    }) {
                                        Image(systemName: "minus")
                                            .font(.system(size:16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    Button(action: {
                                        if cart.quantity > 1{
                                            homeData.cartItems[homeData.getIndex(item: cart.item, isCartIndex: true)].quantity += 1
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size:16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // Bottom View
            VStack{
                HStack{
                    
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    // Calculating Total Price
                    Text(homeData.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                
                Button(action: {}) {
                    Text("Check Out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                        
                            LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color.white]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                }
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

