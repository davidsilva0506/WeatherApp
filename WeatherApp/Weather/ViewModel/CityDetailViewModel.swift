//
//  CityDetailViewModel.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import CoreData

private enum Constants {

    static let dateFormatter = DateFormatter()
    static let dateFormat = "yy/MM/dd HH:mm:ss"
    static let entityName = "CityDetail"
    static let predicateFormat = "name == %@"
    static let assertionMessage = "Error getting saved cities."
}

@MainActor
final class CityDetailViewModel: ObservableObject {
    
    private let service = ServiceLayer()

    @Published var isLoading = false
    @Published var weatherDays = [WeatherDay]()
    @Published var alertItem: AlertItem?

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
    
    func saveCity(city: City, context: NSManagedObjectContext) {
        
        CoreDataService.shared.addCityDetail(city: city, context: context)
    }
    
    func cityExists(city: City, context: NSManagedObjectContext) -> Bool {
        
        var numberOfRecords = 0

        do {
            
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
            fetch.predicate = NSPredicate(format: Constants.predicateFormat, city.name)
            numberOfRecords = try context.count(for: fetch)
            
        } catch {
            
            assertionFailure(Constants.assertionMessage)
        }
        
        return numberOfRecords > 0
    }
}

extension CityDetailViewModel {
    
    static func mapForecast(_ forecast: Forecast) async -> [WeatherForecast] {

        Constants.dateFormatter.dateFormat = Constants.dateFormat

        return forecast.list.compactMap { cityWeather in

            guard let icon = cityWeather.weather.first?.icon,
                  let date = Constants.dateFormatter.date(from: cityWeather.dateString) else {
                
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
        
        return forecastByDay.map { (day, forecast) in
            
            WeatherDay(day: day, forecast: forecast)

        }.sorted(by: { $0.day < $1.day })
    }
}
