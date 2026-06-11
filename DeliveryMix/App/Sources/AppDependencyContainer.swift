import Auth
import Core
import SwiftUI

@MainActor
public class AppDependencyContainer: ObservableObject {
    private let authRepo: AuthRepository
    private let navigationController: UINavigationController  // ← NUEVO

    // MARK: - Initialization
    public init(navigationController: UINavigationController) {  // ← NUEVO parámetro
        self.navigationController = navigationController
        self.authRepo = FirebaseAuthRepository()
    }

    // MARK: - Auth Coordinator
    public func makeAuthCoordinator() -> AuthCoordinator {
        return AuthCoordinator(
            navigationController: navigationController,
            authRepo: authRepo  // ← Cambiado
        )
    }

    // MARK: - Auth ViewModels
    public func makeLoginViewModel() -> LoginViewModel {
        let coordinator = makeAuthCoordinator()
        return LoginViewModel(authRepo: authRepo, coordinator: coordinator)
    }

    public func makeSignUpViewModel(coordinator: AuthCoordinating) -> SignUpViewModel {
        return SignUpViewModel(authRepo: authRepo, coordinator: coordinator)
    }
}
