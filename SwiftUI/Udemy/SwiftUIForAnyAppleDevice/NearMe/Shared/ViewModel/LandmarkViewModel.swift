//
//  LandmarkViewModel.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import Foundation
import MapKit

struct LandmarkViewModel: Identifiable {
    
    let id = UUID()
    let placemark: MKPlacemark
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinator: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
