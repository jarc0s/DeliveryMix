import SwiftUI
import Core

/// Coordinator que maneja la navegación del flujo de autenticación
public class AuthCoordinator: AuthCoordinating {
    
    // MARK: - Properties
    
    /// El navigation controller raíz (UIKit)
    private let navigationController: UINavigationController
    
    /// El dependency container para inyectar dependencias
    private let authRepo: AuthRepository
    
    // MARK: - Initialization
    public init(
        navigationController: UINavigationController,
        authRepo: AuthRepository  // ← Cambiado
    ) {
        self.navigationController = navigationController
        self.authRepo = authRepo
    }
    
    // MARK: - Navigation Methods
    
    @MainActor
    public func goToSignUp() {
            // ✅ Usa authRepo, NO dependencyContainer
            let signUpViewModel = SignUpViewModel(authRepo: authRepo, coordinator: self)
            let signUpView = SignUpView(viewModel: signUpViewModel)
            let hostingController = UIHostingController(rootView: signUpView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    
    @MainActor
    public func goBackToLogin() {
        navigationController.popViewController(animated: true)
    }
    
    @MainActor
    public func goToHome() {
        // Aquí luego reemplazarás con la vista de Home
        print("✅ Navegando al Home...")
        // let homeView = HomeView()
        // let hostingController = UIHostingController(rootView: homeView)
        // navigationController.setViewControllers([hostingController], animated: true)
    }
}
