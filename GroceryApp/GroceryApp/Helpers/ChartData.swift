//
//  ChartData.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 21.02.25.
//

struct ChartData {
    var date: String
    var price: Double
}

extension [String: Double] {
    func getChartData() -> [ChartData] {
        return Array(self)
            .sorted { $0.key < $1.key }
            .map { ChartData(date: $0.key, price: $0.value) }
    }
}
