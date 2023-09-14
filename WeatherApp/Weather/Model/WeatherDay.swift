//
//  WeatherDay.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation

struct WeatherDay: Identifiable {

    var id: String {
    
        return UUID().uuidString
    }

    let day: String
    let forecast: [DayForecast]
}
