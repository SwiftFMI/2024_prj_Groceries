//
//  MapViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 19.02.25.
//

import MapKit

class MapViewModel: ObservableObject {
    @Published var superMarketLocations: [MKMapItem] = []
    @Published var selectedOption = SuperMarkets.billa.rawValue
    let options = [SuperMarkets.billa.rawValue, SuperMarkets.kaufland.rawValue, SuperMarkets.lidl.rawValue]
    
    @Published var position = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.6977, longitude: 23.3219),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    
    func searchSuperMarkets(superMarket: String) {
        let coordinate = position.center
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

extension MKMapItem: Identifiable {
    public var id: UUID {
        return UUID()
    }
}
