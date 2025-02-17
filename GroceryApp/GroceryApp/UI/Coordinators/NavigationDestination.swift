//
//  NavigationDestination.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

enum NavigationDestination {

    // Home
    case home(viewModel: HomeViewModel)

    // Shopiing Cart
    case shoppingCart(viewModel: ShoppingCartViewModel)

    // Profile
    case profile(viewModel: ProfileViewModel)

}

extension NavigationDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
            case let (.home(lhsVM), .home(rhsVM)):
            lhsVM === rhsVM
        case let (.shoppingCart(lhsVM), .shoppingCart(rhsVM)):
            lhsVM === rhsVM
        default:
            false
        }
    }
}

extension NavigationDestination: View {
    var body: some View {
        switch self {
            case let .home(viewModel):
//                HomeView(viewModel: viewModel)
                HomeView()
            case let .shoppingCart(viewModel):
//                ShoppingCartView(viewModel: viewModel)
                ShoppingCartView()
        case let .profile(viewModel: viewModel):
            ProfileView()
        }
    }
}
