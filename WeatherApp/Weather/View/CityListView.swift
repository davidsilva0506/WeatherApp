//
//  CityListView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityListView: View {
    
    @StateObject private var viewModel = CityListViewModel()
    
    @State private var searchTerm = ""

    var body: some View {
        
        NavigationStack {
            
            List(viewModel.cities, id: \.name) { city in
                Text("\(city.name), \(city.country), \(city.lat)")
                    .onTapGesture {
                    
                        viewModel.activeCity = city
                        viewModel.activeSheet = .cityDetailView
                    }
                    .alert(item: $viewModel.alertItem) { alertItem in
                        
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: alertItem.dismiss)
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Cities")
            .sheet(item: $viewModel.activeSheet) { sheet in
                
                switch sheet {
                    
                case .cityDetailView:
                    CityDetailView(city: viewModel.activeCity,
                                   activeSheet: $viewModel.activeSheet)
                case .seetings:
                    SettingsView(activeSheet: $viewModel.activeSheet)
                }
            }
            .toolbar {
                Button(action: {
                    viewModel.activeSheet = .seetings
                 }) {
                    Image(systemName: "gearshape")
                 }
              }
        }

        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { value in
            
            Task {
                
                if value.isEmpty == false,
                   value.count >= 3 {
                    
                    await viewModel.search(searchTerm: value)
                    
                } else {
                    
                    viewModel.cities.removeAll()
                }
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
