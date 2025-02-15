//
//  HomeCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

final class HomeCoordinator: Coordinator, ObservableObject {
    @Published var path = [HomeDestination]()

    var initialDestination: HomeDestination

    @MainActor
    init() {
        let homeViewModel = HomeViewModel()

        self.initialDestination = .home(viewModel: homeViewModel)
    }

    func start() -> some View {
        HomeCoordinatorView(coordinator: self)
    }
}
