//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityDetailView: View {
    
    private enum Constants {
        
        static let buttonDisabledText = "Saved"
        static let buttonEnabledText = "Save city"
        static let buttonWidth: CGFloat = 220
        static let buttonHeight: CGFloat = 40
        static let buttonFontSize: CGFloat = 22
        static let buttonCornerRadius: CGFloat = 10
    }

    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var settings: Settings

    @StateObject private var viewModel: CityDetailViewModel
    
    let service: ServiceLayer
    let city: City
    
    init(service: ServiceLayer, city: City) {
        
        _viewModel = StateObject(wrappedValue: CityDetailViewModel(service: service))
        self.service = service
        self.city = city
    }

    var body: some View {
            
        NavigationStack {
            
            VStack(spacing: 0) {
                
                Button {
                    
                    Task {
                        
                        await viewModel.saveCity(city: city,
                                                 context: context)
                    }
                    
                } label: {
                    
                    Text(viewModel.cityIsSaved ? Constants.buttonDisabledText : Constants.buttonEnabledText)
                        .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                        .font(.system(size: Constants.buttonFontSize, weight: .bold))
                        .cornerRadius(Constants.buttonCornerRadius)
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.cityIsSaved)
                
                Spacer()
                
                MapView(city: city)

                List(viewModel.weatherDays) { day in

                    CityWeatherDayCell(service: self.service, weatherDay: day)
                }
                .navigationTitle(city.name)
            }
        }
        .task {
            
            viewModel.cityExists(city: city, context: context)
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
        CityDetailView(service: ServiceLayer(), city: City(name: "", lat: 0, lon: 0, country: ""))
    }
}
