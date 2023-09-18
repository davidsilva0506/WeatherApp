//
//  WeatherApp.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

@main
struct WeatherApp: App {

    @StateObject private var service = ServiceLayer()
    @StateObject private var coreDataService = CoreDataService()
    @StateObject private var settings = Settings()
    @StateObject private var navigation = Navigation()

    var body: some Scene {
        
        WindowGroup {
            
            CityListView(service: self.service, coreDataService: self.coreDataService)
                .environmentObject(self.settings)
                .environmentObject(self.navigation)
                .environment(\.managedObjectContext, self.coreDataService.container.viewContext)
        }
    }
}
