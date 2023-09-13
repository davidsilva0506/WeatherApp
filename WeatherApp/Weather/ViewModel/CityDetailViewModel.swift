//
//  CityDetailViewModel.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

final class CityDetailViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    private let service = ServiceLayer()
    
    @MainActor
    func getWeather(for city: City?, unit: String) async {
        
        guard let city = city else { return }
       
        isLoading = true

        let forecast = try? await self.service.fetchForecast(city: city, unit: unit)
         
        self.isLoading = false
    }
}
