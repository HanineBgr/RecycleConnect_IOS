//
//  ReviewServices.swift
//  RecycleConnect_IOS
//
//  Created by Marsaoui Mariem on 13/12/2023.
//

import Foundation

class ReviewServices {
    static let shared = ReviewServices()
    
    let baseURL = "http://localhost:5000/api/reviews"
    
    enum NetworkError: Error {
        case invalidURL
        case serializationError
        case decodingError
        case serverError(String)
    }
    
    
    func GetAllReviews(completion: @escaping (Result<[review], Error>) -> Void) {
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
                print("Received Reviews JSON string: \(jsonString)")
            } else {
                print("Received data is not a valid UTF-8 string.")
            }
            
            
            do {
                let reviews = try JSONDecoder().decode([review].self, from: data)
                completion(.success(reviews))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    func DeleteReview(reviewId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(reviewId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    
    func CreateReview(note: Int, avis: String, articleId: String, completion: @escaping (Result<review, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
            let parameters: [String: Any] = [
                "Note": note,
                "Avis": avis,
                "Article": articleId
            ]

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completion(.failure(.serializationError))
                return
            }


            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }

                if let data = data {
                    do {
                        let review = try JSONDecoder().decode(review.self, from: data)
                        completion(.success(review))
                    } catch {
                        completion(.failure(.serializationError))
                    }
                } else {
                    print("Decoding error: \(String(describing: error))")
                    completion(.failure(error as! ReviewServices.NetworkError))
                }
            }.resume()
        }



}
