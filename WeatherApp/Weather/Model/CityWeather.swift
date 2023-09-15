//
//  CityWeather.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct CityWeather: Decodable {
    
    let main: MainWeatherInfo
    let weather: [WeatherInfo]
    let dt_txt: String
}
