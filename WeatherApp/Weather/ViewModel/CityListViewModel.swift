//
//  CityListViewModel.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import Foundation

final class CityListViewModel: ObservableObject {
    
    private let service = ServiceLayer()
    
    var activeCity: City?

    @Published var activeSheet: Sheet?
    @Published var alertItem: AlertItem?
    @Published var cities: [City] = []

    func search(searchTerm: String) async {

        if let cities = try? await self.service.fetchCities(searchTerm: searchTerm) {
            
            DispatchQueue.main.async {
                
                self.cities = cities
            }
            
        } else {
        
            alertItem = AlertContext.requestFailed
        }
    }
}
