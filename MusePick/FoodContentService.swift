//
//  FoodContentService.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 17/04/25.
//

import Foundation
import SwiftUI

class NetworkVegetableAPIService {
    
    private let jsonDecoder = JSONDecoder()

    func fetchVegetables(category: String, completion: @escaping (Result<[FoodContentModel], Error>) -> Void) {
        guard let url = URL(string: "https://assignment.musewearables.com/router/get/category/\(category)") else {
            DispatchQueue.main.async {
                completion(.failure(URLError(.badURL)))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            do {
                let decodedItems = try self.jsonDecoder.decode([FoodContentModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedItems))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
