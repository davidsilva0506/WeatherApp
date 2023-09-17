//
//  CityWeatherDayCell.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

private enum Constants {

    static let horizontalSpacing: CGFloat = 10
    static let timeFontSize: CGFloat = 16
    static let temperatureFontSize: CGFloat = 20
    static let weatherImageSize: CGFloat = 25
}

struct CityWeatherDayCell: View {
    
    let weatherDay: WeatherDay
    
    var body: some View {
        
        Text(weatherDay.day)
            .font(.body)
            .fontWeight(.semibold)
            .scaledToFit()
        
        ScrollView(.horizontal) {
            
            HStack(spacing: Constants.horizontalSpacing) {
                
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
                .font(.system(size: Constants.timeFontSize,
                              weight: .medium))
            
            WeatherImage(iconString: forecast.icon)
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.weatherImageSize, height: Constants.weatherImageSize)
            
            Text("\(forecast.temperature)\(settings.unit.symbol)")
                .font(.system(size: Constants.temperatureFontSize,
                              weight: .medium))
        }
        .padding()
    }
}
