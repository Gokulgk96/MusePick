//
//  FoodDetailsContentView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 18/04/25.
//

import SwiftUI

struct FoodDetailContentView: View {
    @ObservedObject var viewModel: FoodDetailViewModel
    @State var imageStringInteger = 0
    @State private var cartItemCount: Int = 0
    @State private var highlight: Int = 1
    @State private var showingAlert = false
    @State private var quantity = ""
    @State private var selectedNow = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                if let imageURLString = viewModel.foodDetails.sliderImages?[imageStringInteger] ?? viewModel.foodDetails.thumbnailImage,
                   let imageURL = URL(string: imageURLString) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        @unknown default:
                            EmptyView()
                        }
                    } .frame(maxWidth: .infinity)
                        .clipped() // Clip the image to the frame
                } else {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                
                VStack(alignment: .leading, spacing: 15) {
                    // Name and Price
                    Text(viewModel.foodDetails.typeName ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .padding(.top, 40)
                    
                    VStack() {
                        Text("\(viewModel.pricePerPieceFormatted) $/Piece")
                            .font(.title2)
                            .foregroundColor(.primary)
                        Text(viewModel.weightPerPieceFormatted)
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                    }.padding(.leading, 20)
                    
                    Text("Spain")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    
                    
                    // Description
                    if let description = viewModel.foodDetails.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.leading, 20)
                    }
                    HStack(spacing: 20) {
                        Button(action: {
                            DispatchQueue.main.async {
                                if let selected = CommonVariables.selectedArray[viewModel.foodDetails.typeName ?? ""] {
                                    selectedNow = !selected
                                    CommonVariables.selectedArray[viewModel.foodDetails.typeName ?? ""] = selectedNow
                                } else {
                                    CommonVariables.selectedArray[viewModel.foodDetails.typeName ?? ""] = !viewModel.foodDetails.selected
                                    selectedNow = viewModel.foodDetails.selected
                                }
                            }
                            
                        }) {
                            Image(systemName: selectedNow ? "heart.fill" : "heart")
                                .foregroundColor(.gray)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        
                        // Add to Cart Button
                        Button(action: {
                            // Handle add to cart logic here
                            showingAlert.toggle()
                            
                        })  {
                            HStack {
                                Image(systemName: "cart.fill")
                                Text("ADD TO CART")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                        }.frame(alignment: .trailing)
                        
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                        .frame(alignment: .leading)
                    Spacer()
                }
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                .padding(.top, 250)
                .onAppear {
                    if let imageArrayCount = viewModel.foodDetails.sliderImages?.count, imageArrayCount > 1 {
                        imageStringInteger = Int.random(in: 0..<imageArrayCount)
                    } else {
                        imageStringInteger = 0
                    }
                    
                    if let selected = CommonVariables.selectedArray[viewModel.foodDetails.typeName ?? ""] {
                        selectedNow = selected
                    } else {
                        selectedNow = viewModel.foodDetails.selected
                    }
                }
                .alert("Quantity", isPresented: $showingAlert) {
                    TextField("Enter the Required Quantity", text: $quantity)
                        .keyboardType(.numberPad)
                    Button("OK", action: submit)
                }
               
            }
            .background(Color(.systemGray6))
            
            }
            
                .onAppear {
                    cartItemCount = CommonVariables.shoppingCartListItem.count
                    quantity = ""
                    
                }
                .background(Color(.systemGray6))
        
            CustomNavigationBar(cartItemCount: $cartItemCount, highlightedIcon: $highlight)
            .background(Color(.systemGray6))
        }
    
        
    func submit() {
        if !quantity.isEmpty {
            if let cartItemAvailableValue = CommonVariables.shoppingCartListItem[viewModel.foodDetails.typeName ?? ""] {
                CommonVariables.shoppingCartListItem[viewModel.foodDetails.typeName ?? ""] = String((Double(cartItemAvailableValue) ?? 0.0) + ((Double(quantity) ?? 0.0) * (viewModel.foodDetails.pricePerPiece ?? 0.0)))
            } else {
                CommonVariables.shoppingCartListItem[viewModel.foodDetails.typeName ?? ""] = String((Double(quantity) ?? 0.0) * (viewModel.foodDetails.pricePerPiece ?? 0.0))
            }
            
            CommonVariables.totalcost = CommonVariables.totalcost + ((Double(quantity) ?? 0.0) * (viewModel.foodDetails.pricePerPiece ?? 0.0))
            
            CommonVariables.shoppingCartListCount = CommonVariables.shoppingCartListItem.count
            cartItemCount = CommonVariables.shoppingCartListItem.count
        }
    }
    }

