import Foundation

struct TodoModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    var completed: Bool
}
