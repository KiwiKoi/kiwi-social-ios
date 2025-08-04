import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let body: String
    let createdAt: Date
    let updatedAt: Date?
    let author: UserBasic
    let published: Bool
}
