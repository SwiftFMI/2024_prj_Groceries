//
//  ContentCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

struct ContentCoordinatorView: View {
    @ObservedObject var coordinator: ContentCoordinator

    var body: some View {
        tabView
    }

    private var tabView: some View {
        TabView(selection: $coordinator.router.appState.selectedBottomNavigationTab) {
            ForEach(coordinator.tabBarItems, id: \.self) { tab in
                tabItemView(for: tab)
            }
        }
    }

    private func tabItemView(for tab: BottomNavigationTab) -> some View {
        Text("Tab")
            .tabItem {
                Text(tab.key)
            }
            .tag(tab)
    }
}

private extension BottomNavigationTab {
    var key: String {
        switch self {
        case .home:
            "Home"
        case .shoppingCart:
            "My Cart"
        case .profile:
            "Profile"
        }
    }
}
