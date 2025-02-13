//
//  ContentCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

final class ContentCoordinator: Coordinator, ObservableObject {

    let tabBarItems = [BottomNavigationTab]()
    var router: Router

    init(router: Router) {
        self.router = router
    }

    func start() -> some View {
        ContentCoordinatorView(coordinator: self)
    }
}
