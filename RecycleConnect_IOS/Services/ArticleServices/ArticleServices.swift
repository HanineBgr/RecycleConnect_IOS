//
//  ArticleServices.swift
//  RecycleConnect_IOS
//
//  Created by Marsaoui Mariem on 2/12/2023.
//

import Foundation
import SwiftUI

class ArticleServices {
    static let shared = ArticleServices()
        
       //let baseURL = "https://recycleconnect.onrender.com/api/articles"
    let baseURL = "http://localhost:5000/api/articles"
        
        enum NetworkError: Error {
            case invalidURL
            case serializationError
            case decodingError
            case photoNotProvided
            case serverError(String)
        }
        
    
    func GetAllArticles(completion: @escaping (Result<[article], Error>) -> Void) {
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
                        print("Received Articles JSON string: \(jsonString)")
                    } else {
                        print("Received data is not a valid UTF-8 string.")
                    }


                    do {
                        let articles = try JSONDecoder().decode([article].self, from: data)
                        completion(.success(articles))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                }.resume()
            }



    
    func GetArticleById(articleId: String, completion: @escaping (Result<article, Error>) -> Void) {
            guard let url = URL(string: "http://localhost:5000/api/articles/\(articleId)") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                do {
                    let article = try JSONDecoder().decode(article.self, from: data!)
                    completion(.success(article))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()
        }
    

    
    
    
    func DeleteArticle(articleId: String, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let url = URL(string: "\(baseURL)/\(articleId)") else {
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

    
    
    
    static func CreateArticle(
            NomArticle: String,
            DescriptionArticle: String,
            EtatArticle: String,
            Categorie: String,
            PhotoArticle: Data,
            completion: @escaping (Result<article, NetworkError>) -> Void
        ) {
            guard let url = URL(string: "http://localhost:5000/api/articles") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
        
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var body = Data()
            
            // Append image data to the body
            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"PhotoArticle\"; filename=\"photo.jpg\"\r\n", data: &body)
            appendToBody("Content-Type: image/jpeg\r\n\r\n", data: &body)
            body.append(PhotoArticle)
            print("photo", PhotoArticle)
            appendToBody("\r\n", data: &body)

            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"NomArticle\"\r\n\r\n", data: &body)
            appendToBody("\(NomArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"DescriptionArticle\"\r\n\r\n", data: &body)
            appendToBody("\(DescriptionArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"EtatArticle\"\r\n\r\n", data: &body)
            appendToBody("\(EtatArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"CategorieId\"\r\n\r\n", data: &body)
            appendToBody("\(Categorie)\r\n", data: &body)

            appendToBody("--\(boundary)--\r\n", data: &body)

            request.httpBody = body

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.serverError(error?.localizedDescription ?? "Unknown error")))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let article = try decoder.decode(article.self, from: data)
                    completion(.success(article))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }


        private static func appendToBody(_ string: String, data: inout Data) {
            if let stringData = string.data(using: .utf8) {
                data.append(stringData)
            }
        }
    

   /* static func UpdateArticle(
            articleId: String,
            NomArticle: String,
            DescriptionArticle: String,
            EtatArticle: String,
            Categorie: String,
            PhotoArticle: Data,
            completion: @escaping (Result<article, NetworkError>) -> Void
        ) {
            guard let url = URL(string: "http://localhost:5000/api/articles/\(articleId)") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
        
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"

            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var body = Data()
            
            // Append image data to the body
            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"PhotoArticle\"; filename=\"photo.jpg\"\r\n", data: &body)
            appendToBody("Content-Type: image/jpeg\r\n\r\n", data: &body)
            body.append(PhotoArticle)
            print("photo", PhotoArticle)
            appendToBody("\r\n", data: &body)

            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"NomArticle\"\r\n\r\n", data: &body)
            appendToBody("\(NomArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"DescriptionArticle\"\r\n\r\n", data: &body)
            appendToBody("\(DescriptionArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"EtatArticle\"\r\n\r\n", data: &body)
            appendToBody("\(EtatArticle)\r\n", data: &body)


            appendToBody("--\(boundary)\r\n", data: &body)
            appendToBody("Content-Disposition: form-data; name=\"CategorieId\"\r\n\r\n", data: &body)
            appendToBody("\(Categorie)\r\n", data: &body)

            appendToBody("--\(boundary)--\r\n", data: &body)

            request.httpBody = body

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.serverError(error?.localizedDescription ?? "Unknown error")))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let article = try decoder.decode(article.self, from: data)
                    completion(.success(article))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }*/
    func searchArticleByNom(nomArticle: String, completion: @escaping (Result<[article], Error>) -> Void) {
        let url = URL(string: "http://localhost:5000/api/articles/search/\(nomArticle)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Searched Articles JSON string: \(jsonString)")
            } else {
                print("Received data is not a valid UTF-8 string.")
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                let articles = decodedData.articles
                completion(.success(articles))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }


    struct ArticlesResponse: Codable {
        let articles: [article]
    }

    
       
       func SortArticlesByNomAsc(completion: @escaping (Result<[article], Error>) -> Void) {
           let url = URL(string: "\(baseURL)/sort")!
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(NetworkError.decodingError))
                   return
               }
               
               do {
                   let result = try JSONDecoder().decode([String: [article]].self, from: data)
                   if let articles = result["articles"] {
                       completion(.success(articles))
                   } else {
                       completion(.failure(NetworkError.decodingError))
                   }
               } catch {
                   completion(.failure(error))
               }
           }.resume()
       }
    

}
