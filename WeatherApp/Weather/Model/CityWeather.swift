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
    let dateString: String
    
    enum CodingKeys: String, CodingKey {
        
        case main
        case weather
        case dateString = "dt_txt"
    }
}
