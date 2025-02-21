//
//  DetailHistoryViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 21.02.25.
//

import SwiftUI

final class DetailHistoryViewModel: ObservableObject {
    var cartData: ShoppingCartData
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    init(cartData: ShoppingCartData) {
        self.cartData = cartData
    }
}
