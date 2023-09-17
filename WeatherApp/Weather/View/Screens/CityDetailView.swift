//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityDetailView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var navigation: Navigation

    @StateObject var viewModel = CityDetailViewModel()
    
    @Binding var city: City?

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
                    
                    CloseButton()
                }
                .padding()
                
                if let city,
                viewModel.cityExists(city: city,
                                    context: context) == false {
                    
                    Button {
                        
                        viewModel.saveCity(city: city,
                                            context: context)
                        navigation.activeSheet = nil
                        
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
        CityDetailView(city: .constant(nil))
    }
}
