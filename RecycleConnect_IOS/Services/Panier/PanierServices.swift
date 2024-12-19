//
//  PanierService.swift
//  RecycleConnect_IOS
//
//  Created by Aziz Salem on 29/11/2023.
//

import Foundation


class PanierService {
    static let shared = PanierService()
    private init() {}

    func deletePanier(panierId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let baseUrl = "http://localhost:5000/"
        let urlString = baseUrl + "api/panier/delete"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Vérifiez si la réponse est un succès (status code 2xx)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
            }
        }

        task.resume()
    }
}

