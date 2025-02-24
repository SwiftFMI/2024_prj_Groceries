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
    @Published var shoppingCart: [ProductData: Int] = [:]
    @Published var shoppingCartItems: [ProductData] = []

    @Published var billaPriceCombined: Double = 0
    @Published var kauflandPriceCombined: Double = 0
    @Published var lidlPriceCombined: Double = 0

    let auth: FirebaseAuth
    let shoppingCartUpdater: ShoppingCartUpdater
    let createRoadBlockViewModelAction: () -> RoadBlockViewModel
    let openProductPageAction: (ProductData) -> Void
    private var cancellables = Set<AnyCancellable>()

    init(
        auth: FirebaseAuth,
        shoppingCartUpdater: ShoppingCartUpdater,
        openProductPageAction: @escaping (ProductData) -> Void,
        createRoadBlockViewModelAction: @escaping () -> RoadBlockViewModel
    ) {
        self.auth = auth
        self.shoppingCartUpdater = shoppingCartUpdater
        self.createRoadBlockViewModelAction = createRoadBlockViewModelAction
        self.openProductPageAction = openProductPageAction
        isUserLogged = auth.isLoggedIn()

        observeAuthChanges()
        observeShoppingCart()
    }

    var isCartEmpty: Bool {
        shoppingCart.isEmpty
    }

    var bestPrice: Double {
        min(billaPriceCombined, kauflandPriceCombined, lidlPriceCombined)
    }

    var bestPriceProvider: String {
        if billaPriceCombined < kauflandPriceCombined && billaPriceCombined < lidlPriceCombined {
            return "Billa"
        } else if kauflandPriceCombined < billaPriceCombined && kauflandPriceCombined < lidlPriceCombined {
            return "Kaufland"
        } else {
            return "Lidl"
        }
    }

    private func calculateBillaPrice() {
        for shoppingCartItem in shoppingCartItems {
            let itemPrice = (shoppingCartItem.pricesBilla.values.reduce(0, +) / Double(shoppingCartItem.pricesBilla.count))
            let times = shoppingCart[shoppingCartItem]
            billaPriceCombined += (itemPrice * Double(times ?? 1))
        }
    }

    private func calculateKauflandPrice() {
        for shoppingCartItem in shoppingCartItems {
            let itemPrice = (shoppingCartItem.pricesKaufland.values.reduce(0, +) / Double(shoppingCartItem.pricesKaufland.count))
            let times = shoppingCart[shoppingCartItem]
            kauflandPriceCombined += (itemPrice * Double(times ?? 1))
        }
    }

    private func calculateLidlPrice() {
        for shoppingCartItem in shoppingCartItems {
            let itemPrice = (shoppingCartItem.pricesLidl.values.reduce(0, +) / Double(shoppingCartItem.pricesLidl.count))
            let times = shoppingCart[shoppingCartItem]
            lidlPriceCombined += (itemPrice * Double(times ?? 1))
        }
    }

    private func refreshCombinedPrices() {
        billaPriceCombined = 0
        kauflandPriceCombined = 0
        lidlPriceCombined = 0
    }

    private func observeAuthChanges() {
        auth
            .userPublisher
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

    private func observeShoppingCart() {
        shoppingCartUpdater
            .shoppingCartPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shoppingCart in
                guard let self else { return }

                self.shoppingCart = shoppingCart
                self.shoppingCartItems = Array(shoppingCart.keys)

                self.refreshCombinedPrices()
                self.calculateBillaPrice()
                self.calculateKauflandPrice()
                self.calculateLidlPrice()
            }
            .store(in: &cancellables)
    }
}
