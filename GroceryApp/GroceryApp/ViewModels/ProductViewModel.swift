//
//  ProductViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 20.02.25.
//

import Combine
import SwiftUI

final class ProductViewModel: ObservableObject {

    @Published var isUserLogged: Bool
    @Published var currentProviderDisplayed: Providers = .Billa

    let product: ProductData
    let auth: FirebaseAuth
    let shoppingCartUpdater: ShoppingCartUpdater

    private var cancellables = Set<AnyCancellable>()

    init(
        product: ProductData,
        auth: FirebaseAuth,
        shoppingCartUpdater: ShoppingCartUpdater
    ) {
        self.product = product
        self.auth = auth
        self.shoppingCartUpdater = shoppingCartUpdater
        isUserLogged = auth.isLoggedIn()

        observeAuthChanges()
    }

    var billaPrice: Double {
        product.pricesBilla.values.reduce(0, +) / Double(product.pricesBilla.count)
    }

    var kauflandPrice: Double {
        product.pricesKaufland.values.reduce(0, +) / Double(product.pricesKaufland.count)
    }

    var lidlPrice: Double {
        product.pricesLidl.values.reduce(0, +) / Double(product.pricesLidl.count)
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
