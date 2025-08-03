import Foundation

struct Comment: Identifiable, Decodable {
    let id: String
    let body: String
    let createdAt: Date
    let author: UserBasic
}
