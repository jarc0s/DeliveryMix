import FirebaseFirestore
import Foundation

public struct User: Codable, Identifiable {
    @DocumentID public var id: String?
    public let name: String
    public let email: String
    public let createdAt: Date

    public init(id: String? = nil, name: String, email: String, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
    }
}
