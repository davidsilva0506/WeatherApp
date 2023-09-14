//
//  City.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import CoreLocation

struct City: Decodable {

    let name: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let country: String
}
