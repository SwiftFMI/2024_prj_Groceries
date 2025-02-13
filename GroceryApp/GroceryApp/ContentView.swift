//
//  ContentView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

struct ContentView: View {
    let appCoordinator = AppCoordinator()

    var body: some View {
        appCoordinator.start()
    }
}
