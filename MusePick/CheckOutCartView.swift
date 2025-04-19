//
//  CheckOutCartView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 19/04/25.
//

import SwiftUI

struct CheckOutCartView: View {
    @State private var cartItemCount: Int = 0
    @State private var cartItemList: [String: String] = [:]
    @State private var highlight: Int = 2
    @State private var navigateToConfirmationPage = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Check Out Cart")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                
                if CommonVariables.shoppingCartListCount > 0 {
                    List {
                        //loop through the sorted keys
                        ForEach(cartItemList.keys.sorted(), id: \.self) { CartKey in
                            HStack {
                                CartRowView(CartItemsKey: CartKey, CartItemValue: cartItemList[CartKey] ?? "")
                            }
                        }
                    }.background(Color(.systemGray6))
                    HStack(spacing: 20) {
                        Text("Total Cost: $\(getTotalCost())")
                        // Order Now Button
                        Button(action: {
                            // keeping it Empty
                            navigateToConfirmationPage = true
                        }) {
                            Text("PayNow")
                                .font(.system(size: 16, weight: .semibold))
                                .padding()
                                .background(Color.green)
                                .foregroundColor(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .navigationDestination(isPresented: $navigateToConfirmationPage) {
                            ConfirmationView()
                                    }
                    } .padding()
                } else {
                    Spacer()
                    Text("Cart is Empty")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                }
            } .background(Color(.white))
                .onAppear {
                    cartItemCount = CommonVariables.shoppingCartListCount
                    cartItemList = CommonVariables.shoppingCartListItem
                }
            CustomNavigationBar(cartItemCount: $cartItemCount, highlightedIcon: $highlight)
        }
    }
    
    func getTotalCost() -> String {
        return String(CommonVariables.totalcost)
    }
}


struct CartRowView: View {
    let CartItemsKey: String
    let CartItemValue: String

    var body: some View {
        HStack {
            HStack(alignment:.top) {
                Text(CartItemsKey)
                    .font(.headline)
                Spacer()
                Text("$\(CartItemValue)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }.padding(.horizontal)
                
        }
    }
}
