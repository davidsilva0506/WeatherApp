//
//  PinnedCity.swift
//  Weather
//
//  Created by David Silva on 17/09/2023.
//

import Foundation
import MapKit

struct PinnedCity: Identifiable {

    var id: String {
    
        return UUID().uuidString
    }

    let name: String
    let coordinates: CLLocationCoordinate2D
}
