
import Foundation
struct PC: Identifiable, Codable {
    let id: String // Change the type to String
    let Nom_Pc: String
    let address_Pc: String
    let address_mail_Pc: String
    let numero_tel: Int
    let x: Double
    let y: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case Nom_Pc = "Nom_Pc"
        case address_Pc = "address_Pc"
        case address_mail_Pc = "address_mail_Pc"
        case numero_tel = "numero_tel"
        case x = "x"
        case y = "y"
    }

    init() {
        self.id = UUID().uuidString // Convert UUID to String
        self.Nom_Pc = ""
        self.address_Pc = ""
        self.address_mail_Pc = ""
        self.numero_tel = 0
        self.x = 0.0
        self.y = 0.0
    }
}


