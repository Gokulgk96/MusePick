//
//  FoodContentViewModel.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 17/04/25.
//

import SwiftUI

class FoodContentViewModel: ObservableObject {
    @Published var foodItems: [FoodContentModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let apiService = NetworkVegetableAPIService()
  
    func loadFoodList(category: String) {
        isLoading = true
        errorMessage = nil
        apiService.fetchVegetables(category: category) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let fetchedItems):
                self.foodItems = fetchedItems
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Error loading Foods: \(error)")
                self.foodItems = []
            }
        }
    }
}
