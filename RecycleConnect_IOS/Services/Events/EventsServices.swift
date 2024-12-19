//
//  NetworkManager.swift
//  OrogEvents
//
//  Created by Med adem Torkhani on 27/11/2023.
//

import Foundation

final class EventsServices {
    static let shared = EventsServices()

    static let baseUrl = "http://localhost:5000/"
    static let getalleventsUrl = baseUrl + "api/events/"
    static let deleteeventUrl = baseUrl + "api/events/delete/:id"
    static let addevetUrl = baseUrl + "api/events/create"

    private init() {}

    func getEvents(completion: @escaping (Result<[Events], EVError>) -> Void) {
        guard let url = URL(string: EventsServices.getalleventsUrl) else {
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
                let decodedResponse = try decoder.decode(EventsResponse.self, from: data)
                completion(.success(decodedResponse.events))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func deleteEvent(id: String, completion: @escaping (Result<EventsResponseDelet, EVError>) -> Void) {
        guard let url = URL(string: EventsServices.deleteeventUrl.replacingOccurrences(of: ":id", with: id)) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let decodedResponse = try decoder.decode(EventsResponseDelet.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    // Add this method to your EventsServices
    func createEvent(nameEvent: String, descriptionEvent: String, addressEvent: String, startEvent: String, PhotoEvent: String, completion: @escaping (Result<Events, EVError>) -> Void) {
        guard let url = URL(string: EventsServices.addevetUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "nameEvent": nameEvent,
            "descriptionEvent": descriptionEvent,
            "addressEvent": addressEvent,
            "startEvent": startEvent,
            "PhotoEvent": PhotoEvent
        ]

        do {
            // Convert the request body to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let decodedResponse = try decoder.decode(Events.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }














    


    
}
