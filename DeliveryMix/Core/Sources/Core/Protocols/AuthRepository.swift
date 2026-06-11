import Foundation
@MainActor
public protocol AuthRepository {
    func signUp(name: String, email: String, password: String) async throws -> User
    func signIn(email: String, password: String) async throws -> User
    func signOut() throws
    func getCurrentUser() -> User?
}
