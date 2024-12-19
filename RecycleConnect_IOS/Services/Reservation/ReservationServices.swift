import Foundation

class ReservationService {
    static let shared = ReservationService()
    private init() {}

    // Mettez l'adresse de votre serveur local ici
    private let baseUrl = "http://localhost:5000/"

    func addReservation(commentaire: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = baseUrl + "api/reservation/create"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let reservationData: [String: Any] = [
            "commentaire": commentaire,
            "dateReservation": formatter.string(from: Date()),
            "dateLivraison": formatter.string(from: Date()),
            "lieuReservation": "Votre lieu de réservation",
            "etatReservation": "Votre état de réservation",
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reservationData)
        } catch {
            completion(.failure(error))
            return
        }

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
