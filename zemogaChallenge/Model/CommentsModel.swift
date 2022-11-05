import Foundation

struct CommentsModel: Codable,Hashable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
