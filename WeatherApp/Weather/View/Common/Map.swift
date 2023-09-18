//
//  Map.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation
import SwiftUI
import MapKit

private enum Constants {
    
    static let delta = 0.1
    static let mapWidth = UIScreen.main.bounds.size.width
    static let mapHeight: CGFloat = 150
}

struct MapView: View {
    
    var city: City?

    var body: some View {
        
        let coordinates = CLLocationCoordinate2D(latitude: city?.lat ?? 0,
                                                 longitude: city?.lon ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: Constants.delta,
                                    longitudeDelta: Constants.delta)
        let annotations = [PinnedCity(name: city?.name ?? "",
                                      coordinates: coordinates)]

        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinates, span: span)),
            interactionModes: [],
            annotationItems: annotations) {
            
            MapMarker(coordinate: $0.coordinates)
        }
        .frame(width: Constants.mapWidth,
               height: Constants.mapHeight)
    }
}
