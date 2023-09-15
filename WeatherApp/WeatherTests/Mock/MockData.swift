//
//  MockData.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct MockData {
    
    static let mainWeatherInfoA = MainWeatherInfo(temp: 20.0)
    static let weatherInfoA = WeatherInfo(id: 1, icon: "01d")
    
    static let mainWeatherInfoB = MainWeatherInfo(temp: 24.0)
    static let weatherInfoB = WeatherInfo(id: 2, icon: "01d")
    
    static let mainWeatherInfoC = MainWeatherInfo(temp: 30.0)
    static let weatherInfoC = WeatherInfo(id: 3, icon: "01d")
    
    static let cityWeatherA = CityWeather(main: mainWeatherInfoA,
                                         weather: [weatherInfoA],
                                         dt_txt: "2023-09-14 15:00:00")
    
    static let cityWeatherB = CityWeather(main: mainWeatherInfoB,
                                         weather: [weatherInfoB],
                                         dt_txt: "2023-09-15 15:00:00")
    
    static let cityWeatherC = CityWeather(main: mainWeatherInfoB,
                                         weather: [weatherInfoB],
                                         dt_txt: "2023-09-15 15:00:00")
    
    static let forecast = Forecast(cnt: 3, list: [cityWeatherA, cityWeatherB, cityWeatherC])
}
