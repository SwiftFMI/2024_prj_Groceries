//
//  IdentifiableCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

import SwiftUI

final class IdentifiableCoordinator: Coordinator, Identifiable {
    let coordinator: any Coordinator
    let uuid = UUID()

    init(coordinator: any Coordinator) {
        self.coordinator = coordinator
    }

    func start() -> AnyView {
        AnyView(coordinator.start())
    }
}
