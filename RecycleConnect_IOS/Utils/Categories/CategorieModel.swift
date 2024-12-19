import Foundation


struct categorie : Identifiable, Codable , Equatable
{
    
    var id : String
    var PhotoCategorie : URL
    var NomCategorie : String
    var NbreTotalArticles : Int
    var __v : Int
    
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case PhotoCategorie, NomCategorie, NbreTotalArticles, __v
        }

}
