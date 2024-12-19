//
//  NetworkManager.swift
//  OrogEvents
//
//  Created by Med adem Torkhani on 27/11/2023.
//

import Foundation

final class NewsServices {
    static let shared = NewsServices()

    static let baseUrl = "http://localhost:5000/"
    static let getallnewsUrl = baseUrl + "api/news/"

    private init() {}

    func getNews(completion: @escaping (Result<[News], EVError>) -> Void) {
        guard let url = URL(string: NewsServices.getallnewsUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            print("Response Status Code: \(response.statusCode)")

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(decodedResponse.news))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
