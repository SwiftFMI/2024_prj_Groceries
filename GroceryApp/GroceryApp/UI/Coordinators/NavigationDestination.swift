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
    case map(viewModel: MapViewModel)

    // Shared
    case login(viewModel: LoginViewModel)
    case register(viewModel: RegisterViewModel)
    case product(viewModel: ProductViewModel)
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
        case let (.register(lhsVM), .register(rhsVM)):
            lhsVM === rhsVM
        case let (.login(lhsVM), .login(rhsVM)):
            lhsVM === rhsVM
        case let (.profile(lhsVM), .profile(rhsVM)):
            lhsVM === rhsVM
        case let (.map(lhsVM), .map(rhsVM)):
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
            HomeView(viewModel: viewModel)
        case let .shoppingCart(viewModel):
            ShoppingCartView(viewModel: viewModel)
        case let .profile(viewModel: viewModel):
            ProfileView(viewModel: viewModel)
        case let .product(viewModel: viewModel):
            ProductView(viewModel: viewModel)
        case let .login(viewModel):
            LoginView(viewModel: viewModel)
        case let .register(viewModel):
            RegisterView(vm: viewModel)
        case let .map(viewModel: viewModel):
            MapView(viewModel: viewModel)
        }
    }
}
