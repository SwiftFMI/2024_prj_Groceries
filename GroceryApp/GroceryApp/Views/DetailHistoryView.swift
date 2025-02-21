//
//  DetailHistoryView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 21.02.25.
//

import Foundation
import SwiftUI

struct DetailHistoryView : View{
    
    @ObservedObject var viewModel: DetailHistoryViewModel
    
    var body : some View {
        VStack {
            List(viewModel.cartData.carts.keys.sorted(by: { $0.name < $1.name }), id: \.id) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        if let quantity = viewModel.cartData.carts[product] {
                            Text("\(quantity)")
                        }
                    }
                    .contentShape(Rectangle())
                    
                }
            }
        .navigationTitle("My Cart \(viewModel.cartData.date, formatter: viewModel.dateFormatter)")
            Spacer()
        }
    }



