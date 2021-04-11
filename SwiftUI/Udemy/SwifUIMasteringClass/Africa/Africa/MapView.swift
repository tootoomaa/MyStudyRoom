//
//  MapView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/08.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region: MKCoordinateRegion = {
        var mapCoordinaters = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinaters, span: mapZoomLevel)
        return mapRegion
    }()
    
    let locations: [NationalParkLocation] = Bundle.main.decode("locations.json")
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: locations) { item  in
            // (A) Pin: OLD Style(always statc)
//            MapPin(coordinate: item.location, tint: .accentColor)
            
            // (B) Marker: New Style (always static)
//            MapMarker(coordinate: item.location, tint: .accentColor)
            
            // (C) Coustom Basic annotation (it cound be interactive)
//            MapAnnotation(coordinate: item.location) {
//                Image("logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 32, height: 32, alignment: .center)
//            }
            // (D) Custom Advanced Annotation
            MapAnnotation(coordinate: item.location) {
                MapAnnotationView(location: item)
            }
        } //: MAP
        .overlay(
            HStack {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 49, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3, content: {
                    HStack {
                        Text("Latitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    } //: HStack
                    Divider()
                    HStack {
                        Text("Logtitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    } //: HStack
                }) //: VSTack
                    
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                Color.black
                    .cornerRadius(8)
                    .opacity(0.6)
            )
            .padding()
            , alignment: .top
        )
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView()
    }
}
