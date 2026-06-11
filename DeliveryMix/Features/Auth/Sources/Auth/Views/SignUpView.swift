import Core
import SwiftUI

public struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    @Environment(\.dismiss) private var dismiss  // ← Ya no necesitas esto, pero lo dejamos por si acaso

    public init(viewModel: SignUpViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("Full Name", text: $viewModel.name)
                    .textContentType(.name)

                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
            }

            Section(header: Text("Password")) {
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)

                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .textContentType(.newPassword)
            }

            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }

            Section {
                Button(action: {
                    Task { await viewModel.signUp() }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!viewModel.isFormValid || viewModel.isLoading)

                // Botón para volver (AHORA llama al ViewModel)
                Button("Already have an account? Login") {
                    viewModel.goBackToLogin()  // ← CAMBIADO
                }
                .font(.caption)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Sign Up")
    }
}
