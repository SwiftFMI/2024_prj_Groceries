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
    init(firebaseManager: FireStoreManager) {
        let homeViewModel = HomeViewModel(
            firebaseManager: firebaseManager,
            currentSectionIndex: 0,
            presentPicker: { [weak self] items, currentCategoryId, onChanged in
                self?.presentPicker(with: items, currentCategoryId: currentCategoryId, onItemPicked: onChanged)
            },
            openProductPageAction: openProduct
        )

        self.initialDestination = .home(viewModel: homeViewModel)
    }

    func start() -> some View {
        HomeCoordinatorView(coordinator: self)
    }

    private func openProduct(_ product: ProductData) {
        self.path.append(self.productDestination(for: product))
    }
}

extension HomeCoordinator: PickerPresentable {}

extension HomeCoordinator {
    private func productDestination(for product: ProductData) -> HomeDestination {
        .product(viewModel: ProductViewModel(product: product))
    }
}
