//
//  CityWeather.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct CityWeather: Decodable {
    
    let dt: Double
    let main: MainWeatherInfo
    let weather: [Weather]
    let dt_txt: String
}
