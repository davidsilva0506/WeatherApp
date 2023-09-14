//
//  CityWeatherDayCell.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

struct CityWeatherDayCell: View {
    
    let weatherDay: WeatherDay
    
    var body: some View {
        
        Text(weatherDay.day)
            .font(.body)
            .fontWeight(.semibold)
            .scaledToFit()
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(weatherDay.forecast) { forecast in
                    ForecastItemView(forecast: forecast)
                }
            }
        }
    }
}

struct ForecastItemView: View {
    
    @EnvironmentObject var settings: Settings

    let forecast: DayForecast
    
    var body: some View {
        
        VStack() {
            Text("\(forecast.time)h")
                .font(.system(size: 16,
                              weight: .medium))
            
            WeatherImage(iconString: forecast.icon)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            Text("\(forecast.temperature)\(settings.unit.symbol)")
                .font(.system(size: 20,
                              weight: .medium))
        }
        .padding()
    }
}
