//
//  HomeCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject var coordinator: HomeCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.initialDestination
                .navigationDestination(for: HomeDestination.self) { $0 }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
