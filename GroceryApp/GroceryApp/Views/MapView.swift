//
//  MapView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 19.02.25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel: MapViewModel
    
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.position, annotationItems: viewModel.superMarketLocations) { item in
                MapMarker(coordinate: item.placemark.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.all)
            
            Picker("", selection: $viewModel.selectedOption) {
                ForEach(viewModel.options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .cornerRadius(8)
            .frame(maxWidth: .infinity)
            .onChange(of: viewModel.selectedOption) {
                viewModel.searchSuperMarkets(superMarket: viewModel.selectedOption)
            }
            
        }
        .onAppear{
            viewModel.searchSuperMarkets(superMarket: viewModel.selectedOption)
        }
    }
    
}


