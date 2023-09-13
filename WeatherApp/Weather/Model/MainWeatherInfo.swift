//
//  MainWeatherInfo.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct MainWeatherInfo: Decodable {
    
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
}
