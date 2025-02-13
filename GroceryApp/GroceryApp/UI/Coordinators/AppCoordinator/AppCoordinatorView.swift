//
//  AppCoordinatorView.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject var coordinator: AppCoordinator

    var body: some View {
        contentContainerView
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
    }

    @ViewBuilder
    private var contentContainerView: some View {
        if coordinator.initializingAppComponents {
            SplashView()
        } else {
            coordinator.contentView
        }
    }
}
