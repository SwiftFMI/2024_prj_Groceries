//
//  AppCoordinator.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import SwiftUI

final class AppCoordinator: Coordinator, ObservableObject {
    @MainActor @Published private(set) var initializingAppComponents = false

    private lazy var appState: AppState = {
        AppState()
    }()
    
    

    @MainActor
    private lazy var contentCoordinator = {
        ContentCoordinator(appState: appState)
    }()

    init() {}

    func start() -> some View {
        AppCoordinatorView(coordinator: self)
    }

    @MainActor
    var contentView: some View {
        contentCoordinator.start()
    }
}
