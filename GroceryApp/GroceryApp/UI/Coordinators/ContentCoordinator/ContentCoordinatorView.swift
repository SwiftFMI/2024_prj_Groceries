//
//  ContentCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

private enum Constants {
    static let tabBarFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let coordinateSpaceName = "ContentView"
}

struct ContentCoordinatorView: View {
    @ObservedObject var coordinator: ContentCoordinator

    var body: some View {
        tabView
            .coordinateSpace(name: Constants.coordinateSpaceName)
    }

    private var tabView: some View {
        TabView(selection: $coordinator.router.appState.selectedBottomNavigationTab) {
            ForEach(coordinator.tabBarItems, id: \.self) { tab in
                tabItemView(for: tab)
                    .background(.red)
            }
        }
        .id(coordinator.tabBarItems.count)
    }

    private func tabItemView(for tab: BottomNavigationTab) -> some View {
        Text("ads")
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
