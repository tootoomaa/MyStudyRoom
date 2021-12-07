//
//  MapView.swift
//  LandmarksApp
//
//  Created by 김광수 on 2021/12/06.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - Properties
    @State private var region: MKCoordinateRegion
    
    
    // MARK: - Init
    init(coordinate: CLLocationCoordinate2D) {
        let landmarkRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        
        self._region = State(initialValue: landmarkRegion)
    }
    
    // MARK: - Body
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: ModelData().landmarks[0].locationCoordinate)
    }
}
