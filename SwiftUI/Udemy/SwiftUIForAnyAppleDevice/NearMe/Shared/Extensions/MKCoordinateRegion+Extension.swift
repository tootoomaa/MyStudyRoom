//
//  MKCoordinateRegion+Extension.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 29.726819, longitude: -95.393692),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        ) // Apple Campus
    }
    
}
