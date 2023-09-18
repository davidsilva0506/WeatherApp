//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityDetailView: View {
    
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var settings: Settings

    @StateObject private var viewModel = CityDetailViewModel()
    
    let city: City

    var body: some View {
            
        NavigationStack {

            if viewModel.cityExists(city: city,
                                    context: context) == false {
                
                Button {
                        
                    viewModel.saveCity(city: city,
                                       context: context)
                    
                } label: {
                    
                    Text("Save City Info")
                        .frame(width: 280, height: 50)
                        .font(.system(size: 22, weight: .bold))
                        .cornerRadius(10)
                }
                .tint(.white)
                .buttonStyle(.bordered)
            }
            
            Spacer()
            
            MapView(city: city)

            List(viewModel.weatherDays) { day in
                
                CityWeatherDayCell(weatherDay: day)
            }
            .navigationTitle(city.name)
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

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(city: City(name: "",
                                  lat: 0,
                                  lon: 0,
                                  country: ""))
    }
}
