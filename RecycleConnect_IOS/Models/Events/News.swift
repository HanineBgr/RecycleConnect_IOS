import Foundation

struct News: Identifiable, Decodable {
    var id: String { _id }
    
    let _id: String
    let title: String
    let newsPhoto: String
    let description: String
    let source: String
}
struct NewsResponse: Decodable {
    let success: Bool
    let news: [News]
}

struct MockDataNews {
    static let sampleNews = News(_id: "1", title: "aaaaaaaaa", newsPhoto: "newsPhoto", description: "dzdzdzdzd", source: "fafafafazf")
    
}
