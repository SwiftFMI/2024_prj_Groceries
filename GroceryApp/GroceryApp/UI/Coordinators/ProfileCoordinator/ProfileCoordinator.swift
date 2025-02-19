//
//  ProfileCoordinator.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

final class ProfileCoordinator: ObservableObject, Coordinator{
    @Published var path = [ProfileDestionation]()

    var initialDestination: ProfileDestionation

    @MainActor
    init() {
        let profileViewModel = ProfileViewModel()

        self.initialDestination = .profile(viewModel: profileViewModel)
    }

    func start() -> some View {
        ProfileCoordinatorView(coordinator: self)
    }
}
