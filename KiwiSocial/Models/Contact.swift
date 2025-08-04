import Foundation

struct Contact: Identifiable, Codable {
    let id: String
    let requesterId: String
    let recipientId: String
    let requesterUsername: String
    let recipientUsername: String
    let status: ContactStatus
    let chatId: String
}

enum ContactStatus: String, Codable {
    case accepted = "ACCEPTED"
    case pending = "PENDING"
    case blocked = "BLOCKED"
}
