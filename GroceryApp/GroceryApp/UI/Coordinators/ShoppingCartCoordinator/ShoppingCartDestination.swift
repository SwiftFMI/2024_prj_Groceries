//
//  ShoppingCartDestination.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct ShoppingCartDestination {
    private let destination: NavigationDestination

    private init(destination: NavigationDestination) {
        self.destination = destination
    }

    static func shoppingCart(viewModel: ShoppingCartViewModel) -> Self {
        .init(destination: .shoppingCart(viewModel: viewModel))
    }
}

extension ShoppingCartDestination: Hashable {}

extension ShoppingCartDestination: View {
    var body: some View {
        destination
    }
}
