//
//  ContentCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

struct ContentCoordinatorView: View {
    @ObservedObject var coordinator: ContentCoordinator
    
    @State var fs = FireStoreManager()

    var body: some View {
        tabView
    }

    private var tabView: some View {
        TabView(selection: $coordinator.appState.selectedBottomNavigationTab) {
            ForEach(coordinator.tabBarItems, id: \.self) { tab in
                tabItemView(for: tab)
            }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.systemGray4
        }
    }

    private func tabItemView(for tab: BottomNavigationTab) -> some View {
        coordinator.tabView(for: tab)
            .tabItem {
                VStack {
                    tab.image
                    Text(tab.key)
                }
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

    var image: Image {
        switch self {
        case .home:
            Image(systemName: "house")
        case .shoppingCart:
            Image(systemName: "cart")
        case .profile:
            Image(systemName: "person")
        }
    }
}
