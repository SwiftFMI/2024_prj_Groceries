//
//  AppCoordinator.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import SwiftUI

final class AppCoordinator: Coordinator, ObservableObject {
    @MainActor @Published private(set) var initializingAppComponents = false

    private lazy var router: Router = {
        Router(appState: AppState())
    }()
    
    

    @MainActor
    private lazy var contentCoordinator = {
        ContentCoordinator(router: router)
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
