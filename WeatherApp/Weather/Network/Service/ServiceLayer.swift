//
//  ServiceLayer.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import UIKit

private enum Constants {

    static let serviceName = "Open Weather API"
    static let baseURL = "https://api.openweathermap.org"
    static let apiKey = "e162ec3d70d085243b4d63c68a5ca070"
}

final class ServiceLayer: ServiceProtocol {
    
    internal let networkLayer: NetworkLayer
    
    init() {

        let config = NetworkConfig(name: Constants.serviceName,
                                   baseURL: Constants.baseURL,
                                   apiKey: Constants.apiKey)

        self.networkLayer = NetworkLayer(networkConfig: config)
    }

    func fetchCities(searchTerm: String) async throws -> [City]? {
        
        let citiesRequest = CitiesRequest(cityName: searchTerm)
        
        var cities: [City]?

        do {
            
            cities = try await self.networkLayer.execute(type: [City].self, request: citiesRequest)
            
        } catch {
            
            throw error
        }
        
        return cities
    }
    
    func fetchForecast(city: City, unit: String) async throws -> Forecast? {
        
        let forecastRequest = ForecastRequest(city: city, units: unit)
        
        var forecast: Forecast?

        do {
            
            forecast = try await self.networkLayer.execute(type: Forecast.self, request: forecastRequest)
            
        } catch {
            
            throw error
        }
        
        return forecast
    }
    
    func fetchImage(iconString: String) async -> UIImage? {

        let imageRequest = ImageRequest(icon: "\(iconString).png")
        
        var icon: UIImage?
            
        let data = try? await self.networkLayer.data(for: imageRequest, includeAppId: false)
            
        if let data = data,
            let image = UIImage(data: data) {
                
            icon = image
        }

        return icon
    }
}
