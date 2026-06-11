import Core
import FirebaseCore
import SwiftUI
import Auth

//public final class AppDelegate: NSObject, UIApplicationDelegate {
//    public func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//    ) -> Bool {
//        FirebaseApp.configure()
//        print("✅ Firebase configured")
//        return true
//    }
//}

// MARK: - Wrapper para UINavigationController
struct NavigationControllerWrapper: UIViewControllerRepresentable {
    let navigationController: UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

public struct AppView: View {  // ← Renombrado y sin @main
    private let navigationController = UINavigationController()

    public init() {}
    
    public var body: some View {  // ← Devuelve View, no Scene
            NavigationControllerWrapper(navigationController: navigationController)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    setupRootView()
                }
        }

    @MainActor
    private func setupRootView() {
        let container = AppDependencyContainer(navigationController: navigationController)
        let loginViewModel = container.makeLoginViewModel()
        let loginView = LoginView(viewModel: loginViewModel)
        let hostingController = UIHostingController(rootView: loginView)
        navigationController.setViewControllers([hostingController], animated: false)
    }
}
