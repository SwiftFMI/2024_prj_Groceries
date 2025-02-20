//
//  ProductViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 20.02.25.
//

import SwiftUI

final class ProductViewModel: ObservableObject {
    let product: ProductData

    init(product: ProductData) {
        self.product = product
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
}
