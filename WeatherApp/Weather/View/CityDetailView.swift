//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityDetailView: View {
    
    var city: City?

    @StateObject var viewModel = CityDetailViewModel()
    
    @Binding var activeSheet: Sheet?

    var body: some View {
        
        ZStack {
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                       
                        activeSheet = nil
                        
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .imageScale(.large)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding()
                
                Spacer()
            }
            .task {
                
                await viewModel.getWeather(for: city,
                                           unit: "metric")
            }
            
            if viewModel.isLoading {
                
                LoadingView()
            }
        }
    }
}

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(city: City(name: "",
                                  lat: 0,
                                  lon: 0,
                                  country: ""),
                       activeSheet: .constant(nil))
    }
}
