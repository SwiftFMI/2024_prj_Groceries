//
//  HomeViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published private(set) var categories: [Category] = []
    @Published var currentCategoryIndex: Int = 0

    let presentPicker: PresentSectionPicker
    let firebaseManager: FireStoreManager

    let openProductPageAction: (ProductData) -> Void

    private var cancellables: Set<AnyCancellable> = []

    init(
        firebaseManager: FireStoreManager,
        currentSectionIndex: Int,
        presentPicker: @escaping PresentSectionPicker,
        openProductPageAction: @escaping (ProductData) -> Void
    ) {
        self.firebaseManager = firebaseManager
        self.currentCategoryIndex = currentSectionIndex
        self.presentPicker = presentPicker
        self.openProductPageAction = openProductPageAction

        configureCategoriesPublisher()
    }

    var sectionName: String? {
        currentCategory?.name
    }

    private var currentCategory: Category? {
        guard categories.indices.contains(currentCategoryIndex) else {
            return nil
        }
        return categories[currentCategoryIndex]
    }

    func changeCategory(to newCategoryId: String) {
        let newCategoryIndex = categories.firstIndex { $0.id == newCategoryId } ?? 0
        currentCategoryIndex = newCategoryIndex
    }

    func averagePrice(for product: ProductData) -> Double {
        return (product.pricesBilla.values.reduce(0, +) / Double(product.pricesBilla.count) + product.pricesLidl.values.reduce(0, +) / Double(product.pricesLidl.count) + product.pricesKaufland.values.reduce(0, +) / Double(product.pricesKaufland.count)) / 3
    }

    private func configureCategoriesPublisher() {
        firebaseManager
            .categoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                guard let self = self else {
                    return
                }
                print("± \(categories)")
                self.categories = categories
            }
            .store(in: &cancellables)
    }
}
