//
//  ShoppingCartViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI
import FirebaseAuth
import Combine

final class ShoppingCartViewModel: ObservableObject {

    @Published var isUserLogged: Bool

    let auth: FirebaseAuth
    let createRoadBlockViewModelAction: () -> RoadBlockViewModel
    private var cancellables = Set<AnyCancellable>()

    init(
        auth: FirebaseAuth,
        createRoadBlockViewModelAction: @escaping () -> RoadBlockViewModel
    ) {
        self.auth = auth
        self.createRoadBlockViewModelAction = createRoadBlockViewModelAction
        isUserLogged = auth.isLoggedIn()
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
        auth.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let user else {
                    self?.isUserLogged = false
                    return
                }
                self?.isUserLogged = true
            }
            .store(in: &cancellables)
    }
}
