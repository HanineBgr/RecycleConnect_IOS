//
//  CategorieServices.swift
//  RecycleConnect_IOS
//
//  Created by Marsaoui Mariem on 2/12/2023.
//

import Foundation


class CategorieServices {
    static let shared = CategorieServices()
        
        let baseURL = "http://localhost:5000/api/categories"
    //let baseURL = "https://recycleconnect.onrender.com/api/categories"
        
        enum NetworkError: Error {
            case invalidURL
            case serializationError
            case decodingError
        }
        
    
    func GetAllCategories(completion: @escaping (Result<[categorie], Error>) -> Void) {
            guard let url = URL(string: baseURL) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }


            var request = URLRequest(url: url)
            request.httpMethod = "GET"


            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }


                guard let data = data else {
                    print("No data received")
                    completion(.failure(NetworkError.decodingError))
                    return
                }


                if let jsonString = String(data: data, encoding: .utf8) {
                   // print("Received Categories JSON string: \(jsonString)")
                } else {
                    print("Received data is not a valid UTF-8 string.")
                }


                do {
                    let categories = try JSONDecoder().decode([categorie].self, from: data)
                    completion(.success(categories))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            }.resume()
        }



    
    
    
    
    func CreateCategorie(NomCategorie: String, NbreTotalArticles: Int, completion: @escaping (Result<categorie, Error>) -> Void) {
        let parameters: [String: Any] = [
            "NomCategorie": NomCategorie,
            "NbreTotalArticles": NbreTotalArticles
        ]

        guard let url = URL(string: baseURL + "CreateCategorie") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NetworkError.serializationError))
            return
        }

        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let categorie = try JSONDecoder().decode(categorie.self, from: data)
                    completion(.success(categorie))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
