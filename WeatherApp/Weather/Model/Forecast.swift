//
//  Forecast.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct Forecast: Decodable {
    
    let cnt: Int
    let list: [CityWeather]
}
