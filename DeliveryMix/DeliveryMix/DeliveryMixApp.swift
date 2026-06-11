//
//  DeliveryMixApp.swift
//  DeliveryMix
//
//  Created by Jarkos on 25/05/26.
//

import App
import SwiftUI
import FirebaseCore

// Configurar Firebase ANTES de la App
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("✅ Firebase configured")
        return true
    }
}

@main
struct DeliveryMixApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
