
import Foundation

struct ReservationPc: Identifiable, Codable {
    var id: String?
    let nomR: String
    let idPc: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nomR = "Nom_R"
        case idPc = "id_Pc"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        nomR = try container.decode(String.self, forKey: .nomR)
        idPc = try container.decode(String.self, forKey: .idPc)
    }

    init(nomR: String, idPc: String) {
        self.id
        self.nomR = nomR
        self.idPc = idPc
    }
}

extension ReservationPc {
    static func decode(from data: Data) throws -> [ReservationPc] {
        let decoder = JSONDecoder()
        return try decoder.decode([ReservationPc].self, from: data)
    }
}


