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

    init(appState: AppState) {
        self.appState = appState
    }

    @MainActor
    private lazy var homeCoordinator: HomeCoordinator = {
        HomeCoordinator()
    }()

    @MainActor
    private lazy var shoppingCartCoordinator: ShoppingCartCoordinator = {
        ShoppingCartCoordinator()
    }()
    
    @MainActor
    private lazy var profileCoordinator: ProfileCoordinator = {
        ProfileCoordinator()
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
