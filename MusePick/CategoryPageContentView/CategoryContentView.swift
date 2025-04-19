//
//  CategoryContentView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import SwiftUI

struct CategoryContentView: View {
    @StateObject var viewModel = CategoryContentViewModel()
    @State private var searchText = ""
    @State private var cartItemCount: Int = 0
    @State private var highlight: Int = 1
    @State private var navigatingToFoodPage = false
    @State private var selectedCategories = ""

    var filteredCategories: [CategoryContentModel] {
        if searchText.isEmpty {
            return viewModel.categories
        } else {
            return viewModel.categories.filter { ($0.categoryName ?? "").localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Text(CommonConstants.categories)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView(CommonConstants.loading)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("\(CommonConstants.error) \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredCategories) { category in
                                CategoryItemView(category: category)
                                    .onTapGesture { navigatingToFoodPage = true
                                        selectedCategories = category.categoryType ?? ""
                                        }
                            }
                        }
                        .padding()
                    }
                    .navigationDestination(isPresented: $navigatingToFoodPage) {
                        FoodContentView(selectedCategories: $selectedCategories)
                                }
                }
                    CustomNavigationBar(cartItemCount: $cartItemCount, highlightedIcon: $highlight)
            }
        }
        .onAppear {
            cartItemCount = CommonVariables.shoppingCartListItem.count
            viewModel.loadCategories()
        }
        
        
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(CommonConstants.search, text: $text)
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct CategoryItemView: View {
    let category: CategoryContentModel

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: category.categoryImage ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 120)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)

            Text(category.categoryName ?? "")
                .font(.headline)
                .padding(.top, 8)
                .padding(.leading, 20)
            if let totalItems = category.totalItems {
                if totalItems > 0 {
                    Text("+(\(totalItems))")
                        .font(.subheadline)
                        .padding(.top, 8)
                        .padding(.leading, 30)
                        .padding(.bottom, 10)
                } else {
                    Text(CommonConstants.notAvailable)
                        .font(.subheadline)
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        
    }
}
