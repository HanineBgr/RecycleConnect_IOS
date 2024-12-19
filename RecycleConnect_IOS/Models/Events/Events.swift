import Foundation

struct Events: Identifiable, Decodable {
    var id: String { _id }
    
    let _id: String
    let nameEvent: String
    let startEvent: String
    let descriptionEvent: String
    let PhotoEvent: String
    let addressEvent: String
    let organizer: String
    let interested: [String]
    let going: [String]
    let createdAt: String
    let __v: Int
}

struct EventsResponse: Decodable {
    let success: Bool
    let events: [Events]
}
struct EventsResponseDelet: Decodable {
    let success: Bool
    let message: String
}


struct MockData {
    static let sampleEvent = Events(_id: "5fc0f2f2f2f2f2f2f2f2f2f2", nameEvent: "Event 1", startEvent: "2020-11-27", descriptionEvent: "Description Event 1DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", PhotoEvent: "event1", addressEvent: "Address Event 1", organizer: "Organizer Event 1", interested: ["5fc0f2f2f2f2f2f2f2f2f2f2"], going: ["5fc0f2f2f2f2f2f2f2f2f2f2"], createdAt: "2020-11-27T00:00:00.000Z", __v: 0)
    static let events = [sampleEvent,sampleEvent,sampleEvent,sampleEvent]
}


