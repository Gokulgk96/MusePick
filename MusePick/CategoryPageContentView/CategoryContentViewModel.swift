//
//  CategoryContentViewModel.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import SwiftUI

class CategoryContentViewModel: ObservableObject {
    @Published var categories: [CategoryContentModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let apiService = NetworkAPICategoryService()

    func loadCategories() {
        isLoading = true
        errorMessage = nil
        apiService.fetchCategories { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let fetchedCategories):
                self.categories = fetchedCategories
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("\(CommonConstants.errorCategories)\(error)")
            }
        }
    }
}
