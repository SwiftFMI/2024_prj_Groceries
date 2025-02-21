//
//  ContentCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

final class ContentCoordinator: Coordinator, ObservableObject {

    let tabBarItems: [BottomNavigationTab] = [.home, .shoppingCart, .profile]
    var appState: AppState
    var firebaseManager: FireStoreManager
    let firebaseAuthManager: FirebaseAuth
    let shoppingCartUpdater: ShoppingCartUpdater

    init(
        appState: AppState,
        firebaseManager: FireStoreManager,
        firebaseAuthManager: FirebaseAuth,
        shoppingCartUpdater: ShoppingCartUpdater
    ) {
        self.appState = appState
        self.firebaseManager = firebaseManager
        self.firebaseAuthManager = firebaseAuthManager
        self.shoppingCartUpdater = shoppingCartUpdater
    }

    @MainActor
    private lazy var homeCoordinator: HomeCoordinator = {
        HomeCoordinator(
            firebaseManager: firebaseManager,
            firebaseAuthManager: firebaseAuthManager,
            shoppingCartUpdater: shoppingCartUpdater
        )
    }()

    @MainActor
    private lazy var shoppingCartCoordinator: ShoppingCartCoordinator = {
        ShoppingCartCoordinator(
            auth: firebaseAuthManager,
            shoppingCartUpdater: shoppingCartUpdater
        )
    }()
    
    @MainActor
    private lazy var profileCoordinator: ProfileCoordinator = {
        ProfileCoordinator(firebaseAuth: firebaseAuthManager)
    }()

    func start() -> some View {
        ContentCoordinatorView(coordinator: self)
    }

    @MainActor
    @ViewBuilder func tabView(for tab: BottomNavigationTab) -> some View {
        switch tab {
        case .home:
            homeCoordinator.start()
        case .shoppingCart:
            shoppingCartCoordinator.start()
        case .profile:
            profileCoordinator.start()
        }
    }
}
