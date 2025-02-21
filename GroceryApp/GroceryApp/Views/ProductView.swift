//
//  ProductView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 20.02.25.
//

import Charts
import SwiftUI

struct ProductView: View {

    @StateObject var viewModel: ProductViewModel

    var body: some View {
        VStack(spacing: 16) {
            informationView
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
                        viewModel.shoppingCartUpdater.addItem(viewModel.product)
                    }
                }
            }
        }
    }

    var chartView: some View {
        VStack(spacing: 20) {
            Picker("Provider", selection: $viewModel.currentProviderDisplayed) {
                ForEach(Providers.allCases, id: \.self) { provider in
                    Text(provider.name)
                }
            }
            .pickerStyle(.segmented)
            Chart {
                chartContent(for: viewModel.currentProviderDisplayed)
            }
        }
    }

    private func chartContent(for provider: Providers) -> some ChartContent {
        var data = viewModel.product.pricesBilla.getChartData()
        if provider == .Kaufland {
            data = viewModel.product.pricesKaufland.getChartData()
        } else if provider == .Lidl {
            data = viewModel.product.pricesLidl.getChartData()
        }

        return ForEach(data, id: \.date) { chartData in
            LineMark(
                x: .value("Index", chartData.date),
                y: .value("Value", chartData.price)
            )
            .foregroundStyle(.blue)

            AreaMark(
                x: .value("Index", chartData.date),
                yStart: .value("Value", chartData.price),
                yEnd: .value("Bottom", 0)
            )
            .foregroundStyle(.blue.opacity(0.5))
        }
    }
}
