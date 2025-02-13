//
//  FireBaseModels.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 13.02.25.
//

import Foundation


struct ProductData: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var pricesLidl: [String: Double]
    var pricesKaufland: [String: Double]
    var pricesBilla: [String: Double]
    
    init(id: Int, name: String, pricesLidl: [String: Double], pricesKaufland: [String: Double], pricesBilla: [String: Double]) {
        self.id = id
        self.name = name
        self.pricesLidl = pricesLidl
        self.pricesKaufland = pricesKaufland
        self.pricesBilla = pricesBilla
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: ProductData, rhs: ProductData) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

struct Category: Identifiable, Codable, Hashable {
    var id: String?
    var name: String
    var products: [ProductData]
    
    init(id: String? = nil, name: String, products:[ProductData]){
        self.id = id
        self.name = name
        self.products = products
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
