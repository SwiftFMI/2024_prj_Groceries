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
    }

    var chartView: some View {
        Text("Chart View")
    }
}
