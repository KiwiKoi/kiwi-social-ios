import Foundation

struct Chat: Identifiable, Codable {
    let id: String
    let messages: [Message]
    let participants: [User]?
}
