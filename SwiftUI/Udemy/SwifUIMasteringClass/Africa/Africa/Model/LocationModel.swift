//
//  LocationModel.swift
//  Africa
//
//  Created by 김광수 on 2021/04/11.
//

import Foundation
import MapKit

struct NationalParkLocation: Codable, Identifiable {
    var id: String
    var name: String
    var image: String
    var latitude: Double
    var longitude: Double
    
    // Computed Properties
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


/*
 {
   "id" : "kruger",
   "name" : "Kruger National Park",
   "image" : "map-kruger",
   "latitude" : -23.9883848,
   "longitude" : 31.5525515
 },
 */
