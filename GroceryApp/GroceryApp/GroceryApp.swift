//
//  GroceryApp.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GroceryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
    }
}
