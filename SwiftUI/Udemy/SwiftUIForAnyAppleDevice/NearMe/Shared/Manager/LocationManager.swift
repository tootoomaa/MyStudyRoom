//
//  LocationManager.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func startUpdates() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdates() {
        self.locationManager.stopUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
}
