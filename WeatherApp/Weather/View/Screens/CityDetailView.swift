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
    
    init(service: ServiceLayer,
         coreDataService: CoreDataService,
         city: City) {
        
        self._viewModel = StateObject(wrappedValue: CityDetailViewModel(service: service, coreDataService: coreDataService))

        self.service = service
        self.city = city
    }

    var body: some View {
            
        NavigationStack {
            
            VStack(spacing: 0) {
                
                Button {
                    
                    Task {
                        
                        await self.viewModel.saveCity(city: self.city,
                                                      context: self.context)
                    }
                    
                } label: {
                    
                    Text(self.viewModel.cityIsSaved ? Constants.buttonDisabledText : Constants.buttonEnabledText)
                        .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                        .font(.system(size: Constants.buttonFontSize, weight: .bold))
                        .cornerRadius(Constants.buttonCornerRadius)
                }
                .buttonStyle(.bordered)
                .disabled(self.viewModel.cityIsSaved)
                
                Spacer()
                
                MapView(city: self.city)

                List(viewModel.weatherDays) { day in

                    CityWeatherDayCell(service: self.service, weatherDay: day)
                }
                .navigationTitle(self.city.name)
            }
        }
        .task {
            
            self.viewModel.cityExists(city: self.city, context: self.context)
            await viewModel.getWeather(for: self.city, unit: self.settings.unit.value)
        }
        .alert(item: $viewModel.alertItem) { alert in
            
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismiss)
        }

        if self.viewModel.isLoading {
                
            Loading()
        }
    }
}

struct CityDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CityDetailView(service: ServiceLayer(),
                       coreDataService: CoreDataService(),
                       city: City(name: "", lat: 0, lon: 0, country: ""))
    }
}
