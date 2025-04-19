//
//  CategoryContentService.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import SwiftUI

class NetworkAPICategoryService {
    private let baseURL = URL(string: "https://assignment.musewearables.com/router/get/all/categories")!
    private let jsonDecoder = JSONDecoder()

    func fetchCategories(completion: @escaping (Result<[CategoryContentModel], Error>) -> Void) {
        let url = baseURL

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
                let decodedCategories = try self.jsonDecoder.decode([CategoryContentModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedCategories))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
