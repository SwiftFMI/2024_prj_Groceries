//
//  ProductView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 20.02.25.
//

import SwiftUI

struct ProductView: View {

    @StateObject var viewModel: ProductViewModel

    var body: some View {
        ScrollView {
            informationView
            Text("\(viewModel.isUserLogged)")
            chartView
        }
        .padding()
    }

    var informationView: some View {
        HStack {
            Text(viewModel.product.name)
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Billa - " + String(format: "%.2f", viewModel.billaPrice) + " лв.")
                Text("Kaufland - " + String(format: "%.2f", viewModel.kauflandPrice) + " лв.")
                Text("Lidl - " + String(format: "%.2f", viewModel.lidlPrice) + " лв.")
            }
        }
        .navigationTitle(viewModel.product.name)
        .toolbar {
            if viewModel.isUserLogged {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add to cart") {
                        print("Add to cart")
                    }
                }
            }
        }
    }

    var chartView: some View {
        Text("Chart View")
    }
}
