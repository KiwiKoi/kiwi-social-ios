import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    let firstname: String?
    let lastname: String?
    let sentContacts: [Contact]?
    let requestedContacts: [Contact]?
    let chats: [Chat]?
    let favorites: [String]
    let likedPosts: [String]
    let dislikedPosts: [String]
}
