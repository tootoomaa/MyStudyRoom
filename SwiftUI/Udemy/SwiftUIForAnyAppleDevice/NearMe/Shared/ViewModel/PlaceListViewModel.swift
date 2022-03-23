//
//  PlaceListViewModel.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class PlaceListViewModel: ObservableObject {
    
    private let locationManager: LocationManager
    var cancellable: AnyCancellable?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var landmarks: [LandmarkViewModel]?
    
    init() {
        locationManager = LocationManager()
        cancellable = locationManager.$location.sink { (location) in
            if let location = location {
                DispatchQueue.main.async {
                    self.currentLocation = location.coordinate
                    self.locationManager.stopUpdates()
                }
            }
        }
    }
    
    func startUpdateLocation() {
        locationManager.startUpdates()
    }
    
    func searchLandmarks(searchTerm: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        
        let search = MKLocalSearch(request: request)
        search.start { (reponse, error) in
            if let error = error {
                print(error)
            } else if let reponse = reponse {
                let mapItems = reponse.mapItems
                self.landmarks = mapItems.map{
                    return LandmarkViewModel(placemark: $0.placemark)
                }
            }
        }
    }
}
