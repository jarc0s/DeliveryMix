import FirebaseAuth
import FirebaseFirestore
import Foundation

@MainActor 
public class FirebaseAuthRepository: AuthRepository {
    private let db = Firestore.firestore()

    public init() {}

    public func signUp(name: String, email: String, password: String) async throws -> User {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = User(id: authResult.user.uid, name: name, email: email)

        try await db.collection("users").document(authResult.user.uid).setData([
            "name": name,
            "email": email,
            "createdAt": Timestamp(date: Date()),
        ])

        return user
    }

    public func signIn(email: String, password: String) async throws -> User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let snapshot = try await db.collection("users").document(authResult.user.uid).getDocument()

        guard let data = snapshot.data(),
            let name = data["name"] as? String
        else {
            throw NSError(
                domain: "Auth", code: 404,
                userInfo: [NSLocalizedDescriptionKey: "User data not found"])
        }

        return User(id: authResult.user.uid, name: name, email: email)
    }

    public func signOut() throws {
        try Auth.auth().signOut()
    }

    public func getCurrentUser() -> User? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        return User(id: currentUser.uid, name: "", email: currentUser.email ?? "")
    }
}
