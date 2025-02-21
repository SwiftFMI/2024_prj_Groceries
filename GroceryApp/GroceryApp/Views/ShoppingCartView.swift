//
//  ShoppingCartView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 15.02.25.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @StateObject var viewModel : ShoppingCartViewModel

    @Environment(\.editMode) private var editMode

    var body: some View {
        if viewModel.isUserLogged {
            if viewModel.isCartEmpty {
                emptyView
            } else {
                cartView
            }
        } else {
            RoadBlockView(viewModel: viewModel.createRoadBlockViewModelAction())
        }
    }

    var emptyView: some View {
        Text("I am empty,\n go add something")
            .font(.title)
            .bold()
            .multilineTextAlignment(.center)
            .padding()
    }

    var cartView: some View {
        VStack {
            List {
                ForEach(viewModel.shoppingCartItems, id: \.id) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
//                        if editMode?.wrappedValue.isEditing ?? false {
//                            Button {
//                                viewModel.shoppingCartUpdater.lowerItemCount(product)
//                            } label: {
//                                Text("-")
//                                    .bold()
//                            }
//                        }
                        if let quantity = viewModel.shoppingCart[product] {
                            Text("\(quantity)")
                        }
                        if editMode?.wrappedValue.isEditing ?? false {
                            Button {
                                viewModel.shoppingCartUpdater.addItem(product)
                            } label: {
                                Text("+")
                                    .bold()
                            }

                        }
                    }
                    .contentShape(Rectangle())
                    .if(editMode?.wrappedValue.isEditing ?? false == false) {
                        $0.onTapGesture {
                            viewModel.openProductPageAction(product)
                        }
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else {
                        return
                    }

                    viewModel.shoppingCartUpdater.removeItem(viewModel.shoppingCartItems[index])
                }
            }
            .navigationTitle("My Cart")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.shoppingCartUpdater.finish()
                    } label: {
                        Text("Finish")
                            .bold()
                    }
                }
            }
            Spacer()
            priceView
        }
    }

    var priceView: some View {
        Text("Best Price is \(String(format: "%.2f", viewModel.bestPrice))\n from \(viewModel.bestPriceProvider)")
            .bold()
            .padding()
            .multilineTextAlignment(.center)
    }
}
