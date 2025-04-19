//
//  NavigationBarContentView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 17/04/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    @Binding var cartItemCount: Int
    @Binding var highlightedIcon: Int
    @State var navigateToCartPage = false
    @State var navigateToCategoryPage = false
    @State var navigateToProfilePage = false
    @State var profilePageString = "Page is not Ready YET! Sorry"
    
    var body: some View {
            NavigationStack {
            HStack {
                Button(action: {
                    if highlightedIcon != 1 {
                        navigateToCategoryPage = true
                    }
                }) {
                    Image(systemName: highlightedIcon == 1 ? "square.grid.2x2.fill": "square.grid.2x2")
                        .font(.title2)
                        .foregroundColor(.purple)
                }
                .navigationDestination(isPresented: $navigateToCategoryPage) {
                    CategoryContentView()
                            }
                Spacer()
                Button(action: {
                    
                    
                    if highlightedIcon != 2 {
                        navigateToCartPage = true
                    }
                }) {
                    ZStack {
                        Image(systemName: highlightedIcon == 2 ? "cart.fill": "cart")
                            .font(.title2)
                            .foregroundColor(.purple)
                        
                        if cartItemCount > 0 {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 20, height: 20)
                                .offset(x: 10, y: -10)
                            
                            Text("\(cartItemCount)")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .offset(x: 10, y: -10)
                        }
                          
                    }  .navigationDestination(isPresented: $navigateToCartPage) {
                        CheckOutCartView()
                                }
                }
                Spacer()
                Button(action: {
                    if highlightedIcon != 3 {
                        navigateToProfilePage = true
                    }
                }) {
                    Image(systemName: highlightedIcon == 3 ? "person.fill": "person" )
                        .font(.title2)
                        .foregroundColor(.purple)
                }
                .navigationDestination(isPresented: $navigateToProfilePage) {
                    NotDevelopedView(selectedText: $profilePageString)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
            .padding(.horizontal)
        }
    }
    
}
