//
//  CityListViewModel.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import Foundation

@MainActor
final class CityListViewModel: ObservableObject {
    
    private let service = ServiceLayer()

    @Published var alertItem: AlertItem?
    @Published var cities: [City] = []

    func search(searchTerm: String) async {

        do {
            
            self.cities = try await self.service.fetchCities(searchTerm: searchTerm) ?? []
            
        } catch {

            self.alertItem = AlertContext.requestFailed
        }
    }
}
