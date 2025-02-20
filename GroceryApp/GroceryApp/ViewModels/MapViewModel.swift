//
//  MapViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 19.02.25.
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var superMarketLocations: [MKMapItem] = []
    @Published var selectedOption = SuperMarkets.billa.rawValue
    let options = [SuperMarkets.billa.rawValue, SuperMarkets.kaufland.rawValue, SuperMarkets.lidl.rawValue]
    
    
    @Published var cameraPosition: MapCameraPosition
    @Published var userLocation: CLLocationCoordinate2D? = nil
    var locationManager: LocationManager

    
    private var defaultPosition = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.6977, longitude: 23.3219),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        cameraPosition = .region(self.defaultPosition)
        observeLocationUpdates()
    }
    
    private func observeLocationUpdates() {
            locationManager.$userLocation
                .compactMap { $0 }
                .sink { [weak self] coordinate in
                    self?.userLocation = coordinate
                    self?.updateCameraPosition(to: coordinate)
                }
                .store(in: &cancellables)
        }
    
    private func updateCameraPosition(to coordinate: CLLocationCoordinate2D) {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
    }
    
    
    func searchSuperMarkets(superMarket: String) {
        let coordinate = userLocation ?? defaultPosition.center
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = superMarket
        request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            if let error = error {
                print("Search error: \(error.localizedDescription)")
                return
            }

            self?.superMarketLocations = response?.mapItems ?? []
        }
    }
}

enum SuperMarkets: String {
    case billa = "Billa"
    case kaufland = "Kaufland"
    case lidl = "Lidl"
}

extension MKMapItem: @retroactive Identifiable {
    public var id: UUID {
        return UUID()
    }
}
