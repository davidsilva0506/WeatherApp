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
        ZStack {
            NavigationStack {
                List(viewModel.cities, id: \.name) { city in
                    Button {
                        viewModel.activeCity = city
                        viewModel.activeSheet = .cityDetailView
                    } label: {
                        Text("\(city.name), \(city.country)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .scaledToFit()
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Cities")
                .sheet(item: $viewModel.activeSheet) { sheet in
                    
                    switch sheet {
                        
                    case .cityDetailView:
                        CityDetailView(city: $viewModel.activeCity,
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
                .overlay {

                    if viewModel.cities.isEmpty {

                        EmptyCityListView()
                    }
                }
            }
            .searchable(text: $searchTerm)
            .autocorrectionDisabled(true)
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
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
