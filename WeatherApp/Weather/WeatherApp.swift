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
    @StateObject private var settings = Settings()
    @StateObject private var navigation = Navigation()

    var body: some Scene {
        
        WindowGroup {
            
            CityListView(service: service)
                .environmentObject(settings)
                .environmentObject(navigation)
                .environment(\.managedObjectContext, CoreDataService.shared.container.viewContext)
        }
    }
}
