
import Foundation

struct review : Identifiable, Codable , Equatable
//, Hashable
{
    var id : String
    var Note : Int
    var Avis : String
    var Article : String?
    var __v : Int
    
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case Note = "Note"
            case Avis = "Avis"
            case Article = "Article"
            case __v = "__v"
        }
    
    
}
