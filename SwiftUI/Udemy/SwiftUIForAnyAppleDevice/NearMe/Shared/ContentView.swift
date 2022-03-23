//
//  ContentView.swift
//  Shared
//
//  Created by 김광수 on 2022/03/22.
//

import SwiftUI
import MapKit

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    
    @StateObject private var placeListVM = PlaceListViewModel()
    @State private var userTackingMode: MapUserTrackingMode = .follow
    @State private var searchTerm: String = ""
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false
    
    var defaultRegion: MKCoordinateRegion {
       return MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 29.726819, longitude: -95.393692),
           span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
       ) // Apple Campus
   }
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = placeListVM.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )
    }
    
    var body: some View {
        VStack {
            
            TextField("Search", text: $searchTerm, onEditingChanged: { _ in
                
            }, onCommit: {
                placeListVM.searchLandmarks(searchTerm: searchTerm)
            }).textFieldStyle(RoundedBorderTextFieldStyle())
            
            LandmarkCategoryView { (category) in
                placeListVM.searchLandmarks(searchTerm: category)
            }
            
            Picker("Select", selection: $displayType) {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }.pickerStyle(SegmentedPickerStyle())
            
            if displayType == .map {
                Map(coordinateRegion: getRegion(),
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $userTackingMode,
                    annotationItems: placeListVM.landmarks ?? []) { landmark in
                    MapMarker(coordinate: landmark.coordinator)
                }
                    .gesture(DragGesture()
                                .onChanged({ value in
                        isDragged = true
                    })).overlay(isDragged ? AnyView(RecenterButton {
                        placeListVM.startUpdateLocation()
                        isDragged = false
                    }.padding()) : AnyView(EmptyView()))
            } else if displayType == .list {
                LandmarksListView(landmarks: placeListVM.landmarks ?? [])
            }
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
