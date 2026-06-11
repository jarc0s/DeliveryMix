import Combine
import Core
import SwiftUI

@MainActor
public class SignUpViewModel: ObservableObject {
    @Published public var name = ""
    @Published public var email = ""
    @Published public var password = ""
    @Published public var confirmPassword = ""
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    @Published public var isFormValid = false

    private let authRepo: AuthRepository
    private weak var coordinator: AuthCoordinating?  // ← NUEVO
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    public init(authRepo: AuthRepository, coordinator: AuthCoordinating?) {  // ← NUEVO parámetro
        self.authRepo = authRepo
        self.coordinator = coordinator
        setupValidation()
    }

    private func setupValidation() {
        Publishers.CombineLatest3($email, $password, $confirmPassword)
            .map { email, password, confirmPassword in
                !email.isEmpty && email.contains("@") && password.count >= 6
                    && password == confirmPassword
            }
            .assign(to: &$isFormValid)
    }

    // MARK: - Public Methods

    public func signUp() async {
        isLoading = true
        errorMessage = nil

        do {
            let user = try await authRepo.signUp(name: name, email: email, password: password)
            print("✅ User created: \(user.name)")
            coordinator?.goToHome()  // ← NUEVO: navega al home
        } catch {
            errorMessage = error.localizedDescription
            print("❌ SignUp error: \(error)")
        }

        isLoading = false
    }

    public func goBackToLogin() {  // ← NUEVO método
        coordinator?.goBackToLogin()
    }
}
