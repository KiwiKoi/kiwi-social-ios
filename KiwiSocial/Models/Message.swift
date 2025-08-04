import Foundation

struct Message: Codable {
    let senderId: String
    let content: String
    let timestamp: Date
}
