import SwiftUI

/// Protocolo que define las acciones de navegación que el coordinator debe manejar
public protocol AuthCoordinating: AnyObject {
    /// Navega a la pantalla de registro
    @MainActor
    func goToSignUp()

    /// Regresa a la pantalla de login (desde registro)
    @MainActor
    func goBackToLogin()

    /// Navega al home después de login exitoso
    @MainActor
    func goToHome()
}
