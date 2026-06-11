import SwiftUI
import FirebaseCore
import Core

public final class AppDelegate: NSObject, UIApplicationDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let filePath = Bundle.module.path(forResource: "GoogleService-Info", ofType: "plist"),
           let options = FirebaseOptions(contentsOfFile: filePath) {
            FirebaseApp.configure(options: options)
        } else {
            FirebaseApp.configure()
        }

        return true
    }
}

@main
public struct DeliveryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    public init() {}

    public var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}

private struct AppRootView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.tint)

                Text("DeliveryMix")
                    .font(.title.bold())

                Text("App package integrado")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}
