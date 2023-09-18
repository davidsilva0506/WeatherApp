//
//  CityListViewModel.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import Foundation

@MainActor
final class CityListViewModel: ObservableObject {
    
    private enum Constants {

        static let searchThrottle = 3
    }

    private let service: ServiceLayer

    @Published var alertItem: AlertItem?
    @Published var cities: [City] = []
    
    init(service: ServiceLayer) {
        
        self.service = service
    }

    func search(searchTerm: String) async {

        guard searchTerm.isEmpty == false,
              searchTerm.count >= Constants.searchThrottle else {

            self.cities.removeAll()
            return
        }

        do {
            
            self.cities = try await self.service.fetchCities(searchTerm: searchTerm) ?? []
            
        } catch {

            self.alertItem = AlertContext.requestFailed
        }
    }
}
