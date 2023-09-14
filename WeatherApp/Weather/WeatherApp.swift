//
//  WeatherApp.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

@main
struct WeatherApp: App {

    var settings = Settings()

    var body: some Scene {
        WindowGroup {
            CityListView().environmentObject(settings)
        }
    }
}
