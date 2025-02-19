//
//  ShoppingCartView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 15.02.25.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @StateObject var viewModel : ShoppingCartViewModel
    
    var body: some View {
        
        if viewModel.isUserLogged {
            Text("Shopping Cart View")
        } else {
            RoadBlockView(viewModel: viewModel.createRoadBlockViewModelAction())
        }
    }
}
