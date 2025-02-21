//
//  Providers.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 21.02.25.
//

enum Providers: CaseIterable {
    case Billa
    case Kaufland
    case Lidl

    var name: String {
        switch self {
        case .Billa:
            return "Billa"
        case .Kaufland:
            return "Kaufland"
        case .Lidl:
            return "Lidl"
        }
    }
}
