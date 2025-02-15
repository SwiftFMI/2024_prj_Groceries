//
//  ShoppingCartCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct ShoppingCartCoordinatorView: View {
    @ObservedObject var coordinator: ShoppingCartCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.initialDestination
                .navigationDestination(for: ShoppingCartDestination.self) { $0 }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
