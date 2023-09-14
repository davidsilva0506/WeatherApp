//
//  CityDetailViewModel.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {

    static let dateFormatter = DateFormatter()
    static let dateFormat = "yy/MM/dd HH:mm:ss"
}

@MainActor
final class CityDetailViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var weatherDays = [WeatherDay]()
    @Published var alertItem: AlertItem?
    
    private let service = ServiceLayer()

    func getWeather(for city: City?, unit: String) async {
        
        guard let city = city else { return }
       
        isLoading = true

        var forecast: Forecast?
        var weatherDays = [WeatherDay]()

        do {
            
            forecast = try await self.service.fetchForecast(city: city, unit: unit)
            
        } catch {
            
            alertItem = AlertContext.requestFailed
        }

        if let forecast = forecast {

            let mappedForecast = await CityDetailViewModel.mapForecast(forecast)
            weatherDays = await CityDetailViewModel.groupByDay(mappedForecast)
        }

        self.isLoading = false
        
        self.weatherDays = weatherDays
    }
}

extension CityDetailViewModel {
    
    static func mapForecast(_ forecast: Forecast) async -> [WeatherForecast] {

        Constants.dateFormatter.dateFormat = Constants.dateFormat

        return forecast.list.compactMap { cityWeather in

            guard let icon = cityWeather.weather.first?.icon,
                  let date = Constants.dateFormatter.date(from: cityWeather.dt_txt) else {
                
                return nil
            }
            
            let time = Calendar.current.component(.hour, from: date)
            
            let dayForecast = DayForecast(time: String(time),
                                          temperature: Int(cityWeather.main.temp),
                                          icon: icon)

            let weatherForecast = WeatherForecast(date: date.formatted(.iso8601.year().month().day().dateSeparator(.dash)),
                                                  forecast: dayForecast)
            
            return weatherForecast
        }
    }
    
    static func groupByDay(_ weatherDays: [WeatherForecast]) async -> [WeatherDay] {
        
        let forecastByDay = weatherDays.reduce(into: [String: [DayForecast]]()) {

            $0[$1.date, default: []].append($1.forecast)
        }
        
        return forecastByDay.map { (day: String, forecast: [DayForecast]) in
            
            return WeatherDay(day: day, forecast: forecast)
        }.sorted(by: { $0.day < $1.day })
    }
}
