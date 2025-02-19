//
//  HomeCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

final class HomeCoordinator: Coordinator, ObservableObject {
    @Published var path = [HomeDestination]()
    @Published var sheetCoordinator: IdentifiableCoordinator?

    var initialDestination: HomeDestination!

    @MainActor
    init() {
        let homeViewModel = HomeViewModel(
            categories: [],
            currentSectionIndex: 0,
            presentPicker: { [weak self] items, currentCategoryId, onChanged in
                self?.presentPicker(with: items, currentCategoryId: currentCategoryId, onItemPicked: onChanged)
            }
        )

        self.initialDestination = .home(viewModel: homeViewModel)
    }

    func start() -> some View {
        HomeCoordinatorView(coordinator: self)
    }
}

extension HomeCoordinator: PickerPresentable {}
