//
//  FireBaseModels.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 13.02.25.
//

import Foundation
import FirebaseFirestore

struct ProductData: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var pricesLidl: [String: Double]
    var pricesKaufland: [String: Double]
    var pricesBilla: [String: Double]
    
    init(
        id: Int,
        name: String,
        pricesLidl: [String: Double],
        pricesKaufland: [String: Double],
        pricesBilla: [String: Double]
    ) {
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
    
    init(
        id: String? = nil,
        name: String,
        products:[ProductData]
    ){
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

struct ShoppingCartData : Identifiable, Codable, Hashable {
    var id = UUID()
    var date = Date()
    var carts: [ProductData: Int]
    
    init(carts : [ProductData: Int]){
        self.carts = carts
    }
    
    init(id: UUID = UUID(), date: Date = Date(), carts: [ProductData: Int]) {
            self.id = id
            self.date = date
            self.carts = carts
        }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(carts)
    }
    
    static func == (lhs: ShoppingCartData, rhs: ShoppingCartData) -> Bool {
        return lhs.id == rhs.id && lhs.date == rhs.date
    }
}

extension ProductData {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "pricesLidl": pricesLidl,
            "pricesKaufland": pricesKaufland,
            "pricesBilla": pricesBilla
        ]
    }

    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let name = dictionary["name"] as? String,
              let pricesLidl = dictionary["pricesLidl"] as? [String: Double],
              let pricesKaufland = dictionary["pricesKaufland"] as? [String: Double],
              let pricesBilla = dictionary["pricesBilla"] as? [String: Double] else {
            return nil
        }
        self.id = id
        self.name = name
        self.pricesLidl = pricesLidl
        self.pricesKaufland = pricesKaufland
        self.pricesBilla = pricesBilla
    }
}

extension ShoppingCartData {
    func toDictionary() -> [String: Any] {
        let cartsArray = carts.map { (product, quantity) -> [String: Any] in
            return [
                "product": product.toDictionary(),
                "quantity": quantity
            ]
        }

        return [
            "id": id.uuidString,
            "date": Timestamp(date: date),
            "carts": cartsArray
        ]
    }

    init?(from dictionary: [String: Any]) {
        guard let idString = dictionary["id"] as? String,
              let dateTimestamp = dictionary["date"] as? Timestamp,
              let cartsArray = dictionary["carts"] as? [[String: Any]],
              let uuid = UUID(uuidString: idString) else {
            return nil
        }

        var carts: [ProductData: Int] = [:]
        for item in cartsArray {
            if let productDict = item["product"] as? [String: Any],
               let quantity = item["quantity"] as? Int,
               let product = ProductData(from: productDict) {
                carts[product] = quantity
            }
        }

        self.id = uuid
        self.date = dateTimestamp.dateValue()
        self.carts = carts
    }
}
