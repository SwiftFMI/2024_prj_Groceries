//
//  ShoppingCartCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

final class ShoppingCartCoordinator: Coordinator, ObservableObject {
    @Published var path = [ShoppingCartDestination]()

    var initialDestination: ShoppingCartDestination

    @MainActor
    init() {
        let shoppingCartViewModel = ShoppingCartViewModel()

        self.initialDestination = .shoppingCart(viewModel: shoppingCartViewModel)
    }

    func start() -> some View {
        ShoppingCartCoordinatorView(coordinator: self)
    }
}
