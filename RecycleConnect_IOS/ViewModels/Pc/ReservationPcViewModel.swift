
import Foundation

class ReservationPcViewModel: ObservableObject {
    @Published var reservationPcs: [ReservationPc] = []
    @Published var errorMessage: String?
    @Published var livraisons: [Livraisonn] = []

    // MARK: - POST Method
    

    
    func getReservationPcsFromServer() {
        guard let url = URL(string: "http://localhost:5000/reservationPc") else {
            errorMessage = "URL invalide"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Erreur: \(error.localizedDescription)"
                } else if let data = data {
                    do {
                        self.reservationPcs = try ReservationPc.decode(from: data)
                    } catch {
                        self.errorMessage = "Erreur de décodage JSON: \(error.localizedDescription)"
                    }
                }
            }
        }.resume()
    }
    
    func deleteReservationPc(at index: Int) {
        guard index >= 0 && index < reservationPcs.count else {
            print("Index hors limites")
            return
        }
        
        guard let reservationPcID = reservationPcs[index].id else {
            print("ID de réservation manquant")
            return
        }
        
        guard let url = URL(string: "http://localhost:5000/reservationPc/\(reservationPcID)") else {
            print("URL invalide")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erreur lors de la suppression :", error)
                    self.errorMessage = "Erreur lors de la suppression : \(error.localizedDescription)"
                } else if let response = response as? HTTPURLResponse {
                    print("Code de réponse après suppression :", response.statusCode)
                    if response.statusCode == 200 {
                        // Supprimer la réservation localement
                        self.reservationPcs.remove(at: index)
                    } else {
                        self.errorMessage = "La suppression a échoué avec le code de réponse \(response.statusCode)"
                    }
                }
            }
        }.resume()
    }

    func createReservation(nomR: String, idPc: String) {
        guard let url = URL(string: "http://localhost:5000/reservationPc") else {
            errorMessage = "URL invalide"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let reservation = ReservationPc(nomR: nomR, idPc: idPc) // Créez une instance de la réservation

        do {
            let jsonData = try JSONEncoder().encode(reservation)
            request.httpBody = jsonData
        } catch {
            print("Erreur d'encodage JSON:", error.localizedDescription)
            errorMessage = "Erreur d'encodage JSON: \(error.localizedDescription)"
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erreur lors de la création de la réservation :", error)
                    self.errorMessage = "Erreur lors de la création de la réservation : \(error.localizedDescription)"
                } else if let response = response as? HTTPURLResponse {
                    print("Code de réponse après la création de la réservation :", response.statusCode)
                    if response.statusCode == 201 {
                        // La réservation a été créée avec succès
                        // Vous pouvez mettre à jour la liste des réservations ou effectuer d'autres actions nécessaires ici
                        self.getReservationPcsFromServer()
                    } else {
                        self.errorMessage = "La création de la réservation a échoué avec le code de réponse \(response.statusCode)"
                    }
                }
            }
        }.resume()
    }

}
