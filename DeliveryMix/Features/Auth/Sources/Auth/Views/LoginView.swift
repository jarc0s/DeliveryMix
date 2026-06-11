import Core
import SwiftUI

public struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 20) {
            // Logo
            Image(systemName: "bicycle.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.bottom, 40)

            // Email field
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            // Password field
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.password)

            // Error message
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Login button
            Button(action: {
                Task { await viewModel.login() }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Login")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isFormValid ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(!viewModel.isFormValid || viewModel.isLoading)

            // Sign up link (AHORA llama al ViewModel, no NavigationLink)
            Button("Don't have an account? Sign up") {
                viewModel.goToSignUp()  // ← CAMBIADO
            }
            .font(.caption)
        }
        .padding()
        .navigationTitle("Delivery Mix")
    }
}
