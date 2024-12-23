import SwiftUI

struct ProductModel: Identifiable, Equatable {
    var id: Int = 0
    var prodId: Int = 0
    var name: String = ""
    var price: Double = 0.0
    var image: String = ""
    var avgRating: Int = 0
   
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "prod_id") as? Int ?? 0
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.price = dict.value(forKey: "price") as? Double ?? 0.0
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.avgRating = Int(dict.value(forKey: "avg_rating") as? Double ?? 0.0)
       
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
