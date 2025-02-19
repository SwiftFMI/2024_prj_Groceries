//
//  HomeView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel

    var body: some View {
        Text("Home View")
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.sectionName ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        print("Clicked")
                    }, label: {
                        Text("Categories")
                    })
                }
            }
    }
}
