//
//  CategoryContentModel.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import Foundation

struct CategoryContentModel: Codable, Identifiable {
    var id = UUID()
    let categoryID : Int?
    let categoryType : String?
    let categoryName : String?
    let categoryImage : String?
    let totalItems : Int?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryID"
        case categoryType = "categoryType"
        case categoryName = "categoryName"
        case categoryImage = "categoryImage"
        case totalItems = "totalItems"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryID = try values.decodeIfPresent(Int.self, forKey: .categoryID)
        categoryType = try values.decodeIfPresent(String.self, forKey: .categoryType)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        categoryImage = try values.decodeIfPresent(String.self, forKey: .categoryImage)
        totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
    }

}
