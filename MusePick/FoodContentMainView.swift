//
//  FoodContentMainView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 17/04/25.
//

import Foundation
import SwiftUI

struct FoodContentView: View {
    @StateObject var viewModel = FoodContentViewModel()
    @State private var searchText = ""
    @Binding var selectedCategories: String
    @State private var navigatingToFoodDetailsPage = false
    @State private var clickedCategories: FoodContentModel?
    @State private var cartItemCount: Int = 0
    @State private var highlight: Int = 1
    

    var filteredVegetables: [FoodContentModel] {
        if searchText.isEmpty {
            return viewModel.foodItems
        } else {
            return viewModel.foodItems.filter { ($0.typeName ?? "").localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text(selectedCategories)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .padding()
            
            SearchBar(text: $searchText)
                .padding(.horizontal)
    

            if viewModel.isLoading {
                ProgressView("Loading \(selectedCategories)...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error loading \(selectedCategories): \(errorMessage)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if filteredVegetables.isEmpty {
                Text("No items found in \(selectedCategories).")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(filteredVegetables) { item in
                        FoodRowView(vegetable: item) // Assuming you have this view
                            .onTapGesture { navigatingToFoodDetailsPage = true
                                clickedCategories = item
                                }
                    }
                }
                .listStyle(.plain)
                .navigationDestination(isPresented: $navigatingToFoodDetailsPage) {
                    if let clickedCategories = clickedCategories {
                        FoodDetailContentView(viewModel: FoodDetailViewModel(foodDetails: clickedCategories))
                    }
                }
            }
        }
        CustomNavigationBar(cartItemCount: $cartItemCount, highlightedIcon: $highlight)
        .onAppear {
            cartItemCount = CommonVariables.shoppingCartListItem.count
            viewModel.loadFoodList(category: selectedCategories)
        }
    }
}

struct FoodRowView: View {
    let vegetable: FoodContentModel

    var body: some View {
        HStack {
            if let imageURLString = vegetable.thumbnailImage, let imageURL = URL(string: imageURLString) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.green)
                            .frame(width: 80, height: 80)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.green)
                    .frame(width: 80, height: 80)
            }

            VStack(alignment: .leading) {
                Text(vegetable.typeName ?? "")
                    .font(.headline)
                if let price = vegetable.pricePerPiece {
                    Text("\(String(format: "%.2f", price)) \(vegetable.weightPerPiece != nil ? "$/Kg" : "$/Piece")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
