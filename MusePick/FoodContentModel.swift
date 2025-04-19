//
//  FoodContentView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 17/04/25.
//

import Foundation

struct FoodContentModel: Codable, Identifiable {
    var id = UUID()
    let typeID : Int?
    let typeName : String?
    let description : String?
    let thumbnailImage : String?
    let sliderImages : [String]?
    let pricePerPiece : Double?
    let weightPerPiece : Int?
    var selected = false

    enum CodingKeys: String, CodingKey {

        case typeID = "typeID"
        case typeName = "typeName"
        case description = "description"
        case thumbnailImage = "thumbnailImage"
        case sliderImages = "sliderImages"
        case pricePerPiece = "pricePerPiece"
        case weightPerPiece = "weightPerPiece"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeID = try values.decodeIfPresent(Int.self, forKey: .typeID)
        typeName = try values.decodeIfPresent(String.self, forKey: .typeName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumbnailImage = try values.decodeIfPresent(String.self, forKey: .thumbnailImage)
        sliderImages = try values.decodeIfPresent([String].self, forKey: .sliderImages)
        pricePerPiece = try values.decodeIfPresent(Double.self, forKey: .pricePerPiece)
        weightPerPiece = try values.decodeIfPresent(Int.self, forKey: .weightPerPiece)
    }

}

