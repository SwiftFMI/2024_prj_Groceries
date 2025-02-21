//
//  AppCoordinator.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import Combine
import SwiftUI
import FirebaseCore
import FirebaseAppCheck

final class AppCoordinator: Coordinator, ObservableObject {
    @MainActor @Published private(set) var initializingAppComponents = true

    private let firebaseAuth: FirebaseAuth
    private let firebaseManager: FireStoreManager

    private var cancellables = [AnyCancellable]()

    private lazy var appState: AppState = {
        AppState()
    }()

    @MainActor
    private lazy var contentCoordinator = {
        ContentCoordinator(
            appState: appState,
            firebaseManager: firebaseManager,
            firebaseAuthManager: firebaseAuth,
            shoppingCartUpdater: shoppingCartUpdater
        )
    }()

    private lazy var shoppingCartUpdater = {
        ShoppingCartUpdater(
            firebaseAuth: firebaseAuth,
            firebaseManager: firebaseManager
        )
    }()

    init() {
        FirebaseApp.configure()
        firebaseManager = FireStoreManager()
        firebaseAuth = FirebaseAuth()

        Task {
            await setupAppComponents()
        }
    }

    func start() -> some View {
        AppCoordinatorView(coordinator: self)
    }

    @MainActor
    var contentView: some View {
        contentCoordinator.start()
    }

    @MainActor
    private func setupAppComponents() async {
        await firebaseManager.fetchCategories()
        initializingAppComponents = false
    }
}
