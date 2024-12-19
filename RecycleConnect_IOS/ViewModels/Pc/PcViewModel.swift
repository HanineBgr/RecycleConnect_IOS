
import Foundation
import Combine

class PcViewModel: ObservableObject {
    @Published var pcs = [PC]()

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchData()
    }
    

    func fetchData() {
        guard let url = URL(string: "http://localhost:5000/pointCollecte") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PC].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .dataCorrupted(let context):
                            print("Data Corrupted: \(context)")
                        case .keyNotFound(let key, let context):
                            print("Key '\(key)' not found: \(context)")
                        case .typeMismatch(let type, let context):
                            print("Type '\(type)' mismatch: \(context)")
                        case .valueNotFound(let type, let context):
                            print("Value of type '\(type)' not found: \(context)")
                        @unknown default:
                            print("Unknown decoding error")
                        }
                    }
                }
            } receiveValue: { pcs in
                self.pcs = pcs
            }
            .store(in: &cancellables)
    }
}
