
import Foundation

struct article : Identifiable, Codable , Equatable
//, Hashable
{
    var id : String?
    var PhotoArticle : URL
    var NomArticle : String
    var DescriptionArticle : String
    var EtatArticle : String
    var Categorie : String?
    var __v : Int
    
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case PhotoArticle = "PhotoArticle"
            case NomArticle = "NomArticle"
            case DescriptionArticle = "DescriptionArticle"
            case EtatArticle = "EtatArticle"
            case Categorie = "Categorie"
            case __v = "__v"
        }
    
    
}
