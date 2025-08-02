import Foundation

struct Post: Identifiable, Decodable {
    let id: String
    let body: String
    let createdAt: Date
    let updatedAt: Date?
    let author: UserBasic
    let published: Bool
}
