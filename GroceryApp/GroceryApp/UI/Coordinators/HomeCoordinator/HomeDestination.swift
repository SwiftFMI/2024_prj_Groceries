//
//  HomeDestination.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct HomeDestination {
    private let destination: NavigationDestination

    private init(destination: NavigationDestination) {
        self.destination = destination
    }

    static func home(viewModel: HomeViewModel) -> Self {
        .init(destination: .home(viewModel: viewModel))
    }
}

extension HomeDestination: Hashable {}

extension HomeDestination: View {
    var body: some View {
        destination
    }
}

