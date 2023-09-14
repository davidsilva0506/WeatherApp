//
//  MockData.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct MockData {
    
    static let data: [WeatherDay] = [sampleWeatherDay,
                                     sampleWeatherDay2,
                                     sampleWeatherDay3,
                                     sampleWeatherDay4,
                                     sampleWeatherDay5]

    static let sampleDayForecast = DayForecast(time: "15h00",
                                               temperature: 24,
                                               icon: "01d")
    
    static let sampleForecast = [sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast,
                                 sampleDayForecast]
    
    static let sampleWeatherDay = WeatherDay(day: "Segunda",
                                             forecast: sampleForecast)
    
    static let sampleWeatherDay2 = WeatherDay(day: "Terça",
                                              forecast: sampleForecast)
    
    static let sampleWeatherDay3 = WeatherDay(day: "Quarta",
                                              forecast: sampleForecast)
    
    static let sampleWeatherDay4 = WeatherDay(day: "Quinta",
                                              forecast: sampleForecast)
    
    static let sampleWeatherDay5 = WeatherDay(day: "Sexta",
                                              forecast: sampleForecast)
}
