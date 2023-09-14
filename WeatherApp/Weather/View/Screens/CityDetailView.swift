//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityDetailView: View {
    
    @EnvironmentObject var settings: Settings

    @StateObject var viewModel = CityDetailViewModel()
    
    @Binding var city: City?
    @Binding var activeSheet: Sheet?

    var body: some View {
        
        ZStack {
            Background()
            VStack(spacing: 0) {
                HStack {
                    
                    Text(city?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding()

                    Spacer()
                    
                    CloseButton(activeSheet: $activeSheet)
                }
                .padding()
                
                MapView(city: city)

                List(viewModel.weatherDays) { day in
                    CityWeatherDayCell(weatherDay: day)
                }
            }
            .task {
                
                await viewModel.getWeather(for: city, unit: settings.unit.value)
            }
            .alert(item: $viewModel.alertItem) { alert in
                
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismiss)
            }

            if viewModel.isLoading {
                    
                Loading()
            }
        }
    }
}

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(city: .constant(nil), activeSheet: .constant(nil))
    }
}
