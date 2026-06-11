import Combine
import Core
import SwiftUI

@MainActor
public class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    @Published public var isLoggedIn = false
    @Published public var isFormValid = false

    private let authRepo: AuthRepository
    private weak var coordinator: AuthCoordinating?  // ← NUEVO: débil para evitar retain cycle
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    public init(authRepo: AuthRepository, coordinator: AuthCoordinating?) {  // ← NUEVO parámetro
        self.authRepo = authRepo
        self.coordinator = coordinator

        // Combine: Validación en tiempo real con debounce
        Publishers.CombineLatest($email, $password)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { email, password in
                !email.isEmpty && email.contains("@") && password.count >= 6
            }
            .assign(to: &$isFormValid)
    }

    // MARK: - Public Methods

    public func login() async {
        isLoading = true
        errorMessage = nil

        do {
            let user = try await authRepo.signIn(email: email, password: password)
            print("✅ Logged in: \(user.name)")
            isLoggedIn = true
            coordinator?.goToHome()  // ← NUEVO: notifica al coordinator
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Login error: \(error)")
        }

        isLoading = false
    }

    // MARK: - Navigation

    public func goToSignUp() {  // ← NUEVO método
        coordinator?.goToSignUp()
    }
}
