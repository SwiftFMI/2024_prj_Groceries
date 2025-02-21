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
    
    static func login(viewModel: LoginViewModel) -> Self {
        .init(destination: .login(viewModel: viewModel))
    }
    
    static func register(viewModel: RegisterViewModel) -> Self {
        .init(destination: .register(viewModel: viewModel))
    }

    static func product(viewModel: ProductViewModel) -> Self {
        .init(destination: .product(viewModel: viewModel))
    }
}

extension ShoppingCartDestination: Hashable {}

extension ShoppingCartDestination: View {
    var body: some View {
        destination
    }
}
