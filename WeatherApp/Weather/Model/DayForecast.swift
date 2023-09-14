//
//  DayForecast.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation

struct DayForecast: Identifiable {
    
    var id: String {
    
        return UUID().uuidString
    }

    let time: String
    let temperature: Int
    let icon: String
}
