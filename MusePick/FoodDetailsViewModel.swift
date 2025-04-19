//
//  FoodDetailsViewModel.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 18/04/25.
//

import SwiftUI

class FoodDetailViewModel: ObservableObject {
    @Published var foodDetails: FoodContentModel

    init(foodDetails: FoodContentModel) {
        self.foodDetails = foodDetails
    }

    var pricePerPieceFormatted: String {
        if let price = foodDetails.pricePerPiece {
            return String(format: "%.2f", price)
        } else {
            return "N/A"
        }
    }

    var weightPerPieceFormatted: String {
        if let weight = foodDetails.weightPerPiece {
            return "~ \(weight) gr/ piece"
        } else {
            return ""
        }
    }
}
