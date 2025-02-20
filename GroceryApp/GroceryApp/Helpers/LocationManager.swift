//
//  LocationManager.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 20.02.25.
//

import CoreLocation
import SwiftUI

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static var shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D? = nil

    
    
    private override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
        guard let location: CLLocation = locations.first else { return }
        userLocation = location.coordinate
        print("location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}
